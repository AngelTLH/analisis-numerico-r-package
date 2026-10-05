# analisisnumerico

Biblioteca de análisis numérico implementada con R base.

Versión 1.8.9: revisada contra el material del profesor, con correcciones
de escala numérica y ayudas sincronizadas con los resultados actuales.

## Instalación desde GitHub
```r
install.packages("remotes")
remotes::install_github("AngelTLH/analisis-numerico-r-package")
library(analisisnumerico)
```

## Ayuda
```r
?regula_falsi
?secante
?grafico_secante
?metodo_potencia
?householder_reduction
help(package = "analisisnumerico")
```

Las páginas de ayuda incluyen argumentos, valores, y condiciones de error.

## Secante y evolución geométrica

```r
r <- secante(function(x) x^2 - 2, 1, 2, mostrar = TRUE)
r$historial
grafico_secante()
```

El gráfico reproduce los seis paneles de la diapositiva 6 de U2 para
`f(x) = x^3 - x - 1`, con `x0 = 0.5` y `x1 = 2`. Se pueden cambiar
la función, los puntos, las iteraciones y los límites. No incluye Illinois ni Steffensen.
