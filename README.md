# analisisnumerico

Biblioteca didáctica de análisis numérico implementada únicamente con R base.

## Instalación desde GitHub

Si este contenido está en la raíz del repositorio `analisis-numerico-r-package`:

```r
install.packages("remotes")
remotes::install_github("USUARIO/analisis-numerico-r-package")
library(analisisnumerico)
```

Si se conserva dentro del repositorio completo del proyecto, use:

```r
remotes::install_github(
  "USUARIO/analisis-numerico-r-package",
  subdir = "Codigos/Biblioteca_Examen/paquete/analisisnumerico"
)
```

## Ayuda

```r
?regula_falsi
?metodo_potencia
?householder_reduction
help(package = "analisisnumerico")
```

Las páginas de ayuda incluyen argumentos, valores devueltos, ejemplos y condiciones de error.
