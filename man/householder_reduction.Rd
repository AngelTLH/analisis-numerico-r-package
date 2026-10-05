\name{householder_reduction}
\alias{householder_reduction}
\title{Reduccion de Householder por semejanza}
\description{Aplica reflexiones H A H para obtener forma tridiagonal (A simetrica) o Hessenberg superior (A no simetrica).}
\usage{
householder_reduction(A, tol = 1e-10, signo = c("+", "-"))
}
\arguments{
\item{A}{Matriz real cuadrada finita no vacia.}
\item{tol}{Tolerancia positiva para decidir si A es simetrica, relativa a max(abs(A)); si A es nula se usa escala 1.}
\item{signo}{Convencion del reflector; vea \code{\link{reflector_householder}}.}
}
\value{Lista: T, Q y forma ("tridiagonal" o "Hessenberg"); T = t(Q) \%*\% A \%*\% Q.}
\details{Realiza n-2 pasos; para dimensiones 1 y 2 devuelve A sin cambios. Como cada paso es una semejanza ortogonal, T conserva los valores propios de A. Las entradas que la forma final exige nulas se fijan en cero.}
\examples{
A <- matrix(c(4,1,2,1,3,1,2,1,5),3)
r <- householder_reduction(A)
r$T
max(abs(r$T-t(r$Q) \%*\% A \%*\% r$Q))
B <- matrix(c(1,2,3,4, 4,5,6,7, 7,8,10,1, 2,0,1,3), 4, byrow=TRUE)
householder_reduction(B)$forma
}
\seealso{\code{\link{reflector_householder}}, \code{\link{analisisnumerico-package}}}
