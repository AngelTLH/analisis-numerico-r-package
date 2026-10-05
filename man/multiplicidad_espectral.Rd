\name{multiplicidad_espectral}
\alias{multiplicidad_espectral}
\title{Estimacion de multiplicidades}
\description{Agrupa autovalores proximos y estima dimensiones de espacios propios mediante SVD.}
\usage{
multiplicidad_espectral(A, tol = 1e-6, tol_valores = 1e-6)
}
\arguments{
\item{A}{Matriz numerica cuadrada finita no vacia.}
\item{tol}{Tolerancia real finita positiva para el rango numerico de A-lambda*I.}
\item{tol_valores}{Tolerancia positiva de agrupamiento despues de dividir A por max(Mod(A)).}
}
\value{Data frame: valor, algebraica, geometrica, defectivo.}
\details{Se escala A por su mayor modulo antes de calcular el espectro y los rangos. Si A es nula se usa escala 1. Esto evita tratar una matriz pequena como si fuera nula por una tolerancia absoluta fija. Los autovalores escalados se agrupan por enlace simple con umbral tol_valores*max(1,modulos) y el valor devuelto se expresa en la escala original. La multiplicidad algebraica es el tamano del grupo; la geometrica es n menos el rango numerico del sistema escalado. Puede resultar cero si el promedio del grupo no es un autovalor con la tolerancia de rango: revise las tolerancias en ese caso. Valores distintos demasiado proximos pueden agruparse y valores multiples defectivos pueden separarse numericamente. No es una certificacion simbolica de multiplicidades o diagonalizabilidad.}
\examples{
A <- matrix(c(3,1,0,3),2,byrow=TRUE)
multiplicidad_espectral(A)
P <- matrix(c(1,2,0, 0,1,3, 1,0,1), 3, byrow=TRUE)
J <- matrix(c(2,1,0, 0,2,1, 0,0,2), 3, byrow=TRUE)
multiplicidad_espectral(P \%*\% J \%*\% solve(P))
}
\seealso{\code{\link{espacio_propio}}, \code{\link{analisisnumerico-package}}}
