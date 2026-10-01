\name{householder_qr}
\alias{householder_qr}
\title{Triangularizacion QR de Householder paso a paso}
\description{Aplica reflectores H_1, H_2, ... por la izquierda hasta obtener R = H_k ... H_1 A.}
\usage{
householder_qr(A, signo = c("-", "+"), mostrar = FALSE)
}
\arguments{
\item{A}{Matriz real finita no vacia; puede ser rectangular.}
\item{signo}{Convencion del reflector; vea \code{\link{reflector_householder}}.}
\item{mostrar}{Logico. TRUE imprime v, H_k y A(k) en cada paso.}
}
\value{Lista: Q = H_1 H_2 ... H_k ortogonal (m x m), R triangular superior (m x n) y pasos, una lista con v, H y A (matriz tras el paso) para cada reflector aplicado.}
\details{Realiza min(m-1, n) pasos. En el paso k se refleja la columna k desde la fila k; las entradas bajo la diagonal se fijan en cero y los restos de redondeo menores que 1e-14 por la escala de A se tratan como cero antes de construir el reflector. Si la subcolumna ya es multiplo de e1 y signo es "-", el reflector es la identidad. No se permutan columnas: Q \%*\% R = A.}
\examples{
A <- matrix(c(1,-1,4, 1,4,-2, 1,4,2, 1,-1,0), 4, byrow=TRUE)
r <- householder_qr(A, mostrar=TRUE)
r$pasos[[1]]$H
}
\seealso{\code{\link{descomposicion_qr}}, \code{\link{reflector_householder}}, \code{\link{analisisnumerico-package}}}
