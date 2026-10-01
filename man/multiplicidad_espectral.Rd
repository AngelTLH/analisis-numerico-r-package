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
\item{tol_valores}{Tolerancia real finita positiva para agrupar autovalores, relativa a max(1, modulo).}
}
\value{Data frame: valor, algebraica, geometrica, defectivo.}
\details{Un autovalor multiple defectivo se calcula numericamente como varios valores separados del orden de eps^(1/k). Por eso los autovalores se agrupan por enlace simple con tol_valores y cada grupo se representa por su promedio, que es mucho mas preciso que cada valor aislado. La multiplicidad algebraica es el tamano del grupo y la geometrica es n menos el rango numerico de A-lambda*I (al menos 1). Autovalores distintos a una distancia menor que tol_valores se cuentan como uno solo. Es una estimacion numerica, no una certificacion.}
\examples{
A <- matrix(c(3,1,0,3),2,byrow=TRUE)
multiplicidad_espectral(A)
P <- matrix(c(1,2,0, 0,1,3, 1,0,1), 3, byrow=TRUE)
J <- matrix(c(2,1,0, 0,2,1, 0,0,2), 3, byrow=TRUE)
multiplicidad_espectral(P \%*\% J \%*\% solve(P))
}
\seealso{\code{\link{espacio_propio}}, \code{\link{analisisnumerico-package}}}
