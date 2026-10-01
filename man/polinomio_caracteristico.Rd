\name{polinomio_caracteristico}
\alias{polinomio_caracteristico}
\title{Polinomio caracteristico}
\description{Calcula los coeficientes de p(lambda) = det(lambda*I - A) y sus raices.}
\usage{
polinomio_caracteristico(A)
}
\arguments{
\item{A}{Matriz numerica cuadrada finita no vacia, real o compleja.}
}
\value{Lista: coeficientes (de lambda^n a lambda^0, el primero igual a 1), polinomio (texto) y raices (ordenadas por modulo decreciente).}
\details{Usa el algoritmo de Faddeev-LeVerrier, que solo requiere productos de matrices y trazas. Si A tiene entradas enteras los coeficientes se redondean a enteros. det(A-lambda*I) = (-1)^n p(lambda), por lo que ambas ecuaciones tienen las mismas raices. Las raices se obtienen con polyroot; las raices multiples se calculan con menor precision que los valores de eigen.}
\examples{
A <- matrix(c(4,1,2,3),2,byrow=TRUE)
polinomio_caracteristico(A)
polinomio_caracteristico(matrix(c(5,4,2, 4,5,2, 2,2,2), 3, byrow=TRUE))$polinomio
}
\seealso{\code{\link{valores_vectores_propios}}, \code{\link{analisisnumerico-package}}}
