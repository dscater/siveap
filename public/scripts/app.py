from fastapi import FastAPI
# para analisis de alertas
import pandas as pd #prediccion/alerta
import statsmodels.api as sm

# para prediccion
from pydantic import BaseModel
from typing import Optional,List
import numpy as np
import statsmodels.api as sm
from datetime import datetime, timedelta

app = FastAPI()

#==========================
#   ANALISIS DE ALERTAS
#=========================
@app.post("/analizar")
def analizar(data: dict):

    dias = data["dias"]

    # VALIDAR DATOS
    if len(dias) < 2:

        return {
            "riesgo": "BAJO",
            "indice": 0,
            "prediccion": 0
        }

    # DATAFRAME
    df = pd.DataFrame(dias)

    # INDICE TEMPORAL
    df["dia"] = range(1, len(df) + 1)

    # VARIABLES INDEPENDIENTES
    X = df[[
        "dia",
        "activos",
        "graves",
        "fallecidos"
    ]]

    # AGREGAR CONSTANTE
    X = sm.add_constant(X)

    # VARIABLE DEPENDIENTE
    y = df["confirmados"]

    try:

        # MODELO GLM POISSON
        modelo = sm.GLM(
            y,
            X,
            family=sm.families.Poisson()
        )

        resultado = modelo.fit()

        predicciones = resultado.predict(X)

        prediccion_final = float(
            predicciones.iloc[-1]
        )

    except Exception as e:

        return {
            "error": str(e)
        }

    # ÚLTIMOS VALORES
    activos = int(df["activos"].iloc[-1])

    graves = int(df["graves"].iloc[-1])

    fallecidos = int(df["fallecidos"].iloc[-1])

    confirmados = int(df["confirmados"].iloc[-1])

    # SCORE EPIDEMIOLÓGICO
    indice = (
        confirmados * 1 +
        activos * 2 +
        graves * 4 +
        fallecidos * 8
    )

    # CRECIMIENTO
    crecimiento = 0

    if len(df) >= 2:

        anterior = df["confirmados"].iloc[-2]

        actual = df["confirmados"].iloc[-1]

        crecimiento = actual - anterior

    # CLASIFICACIÓN RIESGO
    riesgo = "BAJO"

    if fallecidos > 0:

        riesgo = "CRITICO"

    elif indice >= 25:

        riesgo = "CRITICO"

    elif indice >= 15:

        riesgo = "ALTO"

    elif indice >= 8:

        riesgo = "MEDIO"

    # CRECIMIENTO ACELERADO
    if crecimiento >= 5 and riesgo != "CRITICO":

        riesgo = "ALTO"

    return {

        "riesgo": riesgo,

        "indice": indice,

        "prediccion": round(
            prediccion_final,
            2
        ),

        "crecimiento": int(crecimiento),

        "confirmados": confirmados,

        "activos": activos,

        "graves": graves,

        "fallecidos": fallecidos
    }
    
#==========================
#   PREDICCIÓN
#==========================
# =========================
# MODELOS

class Dia(BaseModel):
    fecha: str
    confirmados: int

class PrediccionRequest(BaseModel):

    enfermedad_id: Optional[int] = None

    comunidad_id: Optional[int] = None

    dias_predecir: int

    dias: List[Dia]

# =========================
# ENDPOINT
# =========================
@app.post("/predecir")
def predecir(data: PrediccionRequest):

    # DATAFRAME
    df = pd.DataFrame([
        {
            "fecha": x.fecha,
            "confirmados": x.confirmados
        }
        for x in data.dias
    ])


    if len(df) < 3:
        return {
            "success": False,
            "message":
                "Datos insuficientes para predicción"
        }

    # NUMERAR DIAS
    df["dia_num"] = np.arange(
        1,
        len(df) + 1
    )

    # VARIABLES
    X = sm.add_constant(
        df["dia_num"]
    )

    y = df["confirmados"]

    # GLM POISSON
    modelo = sm.GLM(
        y,
        X,
        family=sm.families.Poisson()
    )

    resultado = modelo.fit()

    # =========================
    # PREDECIR FUTURO
    # =========================

    futuros = np.arange(
        len(df) + 1,
        len(df) + data.dias_predecir + 1
    )

    future_X = sm.add_constant(
        futuros
    )

    predicciones = resultado.predict(
        future_X
    )

    # =========================
    # ARMAR RESPUESTA
    # =========================

    ultima_fecha = datetime.strptime(
        df.iloc[-1]["fecha"],
        "%Y-%m-%d"
    )

    resultado_predicciones = []

    for i, valor in enumerate(predicciones):

        fecha_futura = (
            ultima_fecha +
            timedelta(days=i + 1)
        )

        resultado_predicciones.append({

            "dia": i + 1,

            "fecha":
                fecha_futura.strftime(
                    "%Y-%m-%d"
                ),

            "casos_estimados":
                round(float(valor), 2)
        })

    return {

        "riesgo": "ALTO",

       "crecimiento":
    round(
        float(
            resultado.params["dia_num"]
        ),
        2
    ),

        "predicciones":
            resultado_predicciones
    }