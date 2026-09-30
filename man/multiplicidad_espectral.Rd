\name{multiplicidad_espectral}
\alias{multiplicidad_espectral}
\title{Estimacion de multiplicidades}
\description{Agrupa autovalores proximos y estima dimensiones de espacios propios mediante SVD.}
\usage{
multiplicidad_espectral(A, tol = 1e-6)
}
\arguments{
\item{A}{Matriz numerica finita no vacia; consulte las restricciones en Detalles.}
\item{tol}{Tolerancia real finita positiva. Su significado se explica en Valor y Detalles.}
}
\value{Data frame: valor, algebraica, geometrica, defectivo.}
\details{tol es absoluta para agrupar respecto del primer valor no usado y escalada para estimar rango. Es una estimacion numerica: autovalores proximos y matrices mal condicionadas pueden dar multiplicidades ambiguas, no certificadas.}
\examples{
A <- matrix(c(3,1,0,3),2,byrow=TRUE)
multiplicidad_espectral(A)
}
\seealso{\code{\link{analisisnumerico-package}}}

