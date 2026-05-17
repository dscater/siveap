import statsmodels.api as sm
import pandas as pd

data = pd.DataFrame({
    "dias": [1,2,3,4,5],
    "casos": [2,4,5,8,15]
})

X = sm.add_constant(data["dias"])

modelo = sm.GLM(
    data["casos"],
    X,
    family=sm.families.Poisson()
)

resultado = modelo.fit()

prediccion = resultado.predict(X)