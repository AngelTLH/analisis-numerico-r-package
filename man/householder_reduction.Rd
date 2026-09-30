\name{householder_reduction}
\alias{householder_reduction}
\title{Reduccion simetrica de Householder}
\description{Aplica reflexiones por semejanza para obtener estructura tridiagonal.}
\usage{
householder_reduction(A, tol = 1e-10)
}
\arguments{
\item{A}{Matriz numerica finita no vacia; consulte las restricciones en Detalles.}
\item{tol}{Tolerancia real finita positiva. Su significado se explica en Valor y Detalles.}
}
\value{Lista: T, Q; T = t(Q) \%*\% A \%*\% Q.}
\details{Requiere matriz real simetrica dentro de tol escalada por max(1,max(abs(A))). Para dimensiones 1 y 2 no requiere reflexiones. Pueden quedar restos de redondeo fuera de la tridiagonal.}
\examples{
A <- matrix(c(4,1,2,1,3,1,2,1,5),3)
r <- householder_reduction(A)
r$T
max(abs(r$T-t(r$Q) \%*\% A \%*\% r$Q))
}
\seealso{\code{\link{analisisnumerico-package}}}

