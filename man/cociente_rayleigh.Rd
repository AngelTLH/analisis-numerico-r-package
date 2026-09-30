\name{cociente_rayleigh}
\alias{cociente_rayleigh}
\title{Cociente de Rayleigh}
\description{Calcula el cociente de Rayleigh usando conjugacion para vectores complejos.}
\usage{
cociente_rayleigh(A, x)
}
\arguments{
\item{A}{Matriz numerica finita no vacia; consulte las restricciones en Detalles.}
\item{x}{Vector numerico finito; consulte las restricciones en Detalles.}
}
\value{Un escalar real o complejo.}
\details{x debe ser no nulo y tener longitud nrow(A).}
\examples{
A <- matrix(c(4,1,2,3),2,byrow=TRUE)
cociente_rayleigh(A, c(1,1))
}
\seealso{\code{\link{analisisnumerico-package}}}

