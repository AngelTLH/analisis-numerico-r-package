\name{descomposicion_qr}
\alias{descomposicion_qr}
\title{Factorizacion QR}
\description{Factoriza A = QR sin pivoteo de columnas mediante reflexiones de Householder.}
\usage{
descomposicion_qr(A, signo = c("-", "+"))
}
\arguments{
\item{A}{Matriz real finita no vacia; puede ser rectangular.}
\item{signo}{Convencion del reflector; vea \code{\link{reflector_householder}}. Con "-" la diagonal de R conserva el signo del pivote de cada paso.}
}
\value{Lista: Q ortogonal completa (m x m) y R triangular superior o trapezoidal (m x n), con Q \%*\% R = A.}
\details{Equivale a householder_qr sin el registro de pasos. Las columnas no se permutan, por lo que la identidad se cumple con A en su orden original, incluso si A tiene rango deficiente.}
\examples{
A <- matrix(c(1,-1,4, 1,4,-2, 1,4,2, 1,-1,0), 4, byrow=TRUE)
r <- descomposicion_qr(A)
r$R
max(abs(r$Q \%*\% r$R - A))
}
\seealso{\code{\link{householder_qr}}, \code{\link{analisisnumerico-package}}}
