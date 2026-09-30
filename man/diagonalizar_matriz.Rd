\name{diagonalizar_matriz}
\alias{diagonalizar_matriz}
\title{Diagonalizacion numerica}
\description{Calcula una diagonalizacion sobre los complejos y comprueba su reconstruccion.}
\usage{
diagonalizar_matriz(A, tol = 1e-8)
}
\arguments{
\item{A}{Matriz numerica finita no vacia; consulte las restricciones en Detalles.}
\item{tol}{Tolerancia real finita positiva. Su significado se explica en Valor y Detalles.}
}
\value{Lista: P, D, P_inv, error de reconstruccion escalado por max(1,max(abs(A))).}
\details{tol controla el rango numerico de P y el error de reconstruccion. Emite Error si no encuentra una diagonalizacion numericamente fiable; no es una demostracion simbolica.}
\examples{
A <- matrix(c(0,-1,1,0),2,byrow=TRUE)
r <- diagonalizar_matriz(A)
r$P \%*\% r$D \%*\% r$P_inv
}
\seealso{\code{\link{analisisnumerico-package}}}

