\name{descomposicion_qr}
\alias{descomposicion_qr}
\title{Factorizacion QR con pivoteo}
\description{Factoriza con QR de R base y conserva la permutacion de columnas.}
\usage{
descomposicion_qr(A)
}
\arguments{
\item{A}{Matriz numerica finita no vacia; consulte las restricciones en Detalles.}
}
\value{Lista: Q ortogonal completa, R triangular o trapezoidal, pivote (orden de columnas).}
\details{Acepta matrices reales rectangulares. La identidad correcta es Q \%*\% R = A[,pivote,drop=FALSE], no necesariamente A en su orden original.}
\examples{
A <- matrix(c(1,2,3,4,5,7),3)
r <- descomposicion_qr(A)
max(abs(r$Q \%*\% r$R - A[,r$pivote,drop=FALSE]))
}
\seealso{\code{\link{analisisnumerico-package}}}

