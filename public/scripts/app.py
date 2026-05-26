from fastapi import FastAPI
import pandas as pd
import statsmodels.api as sm

app = FastAPI()


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