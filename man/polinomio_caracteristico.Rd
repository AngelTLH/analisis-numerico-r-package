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
\details{Usa Faddeev-LeVerrier, con productos de matrices y trazas. Si A tiene entradas enteras y los coeficientes calculados son menores que 2^52 en modulo, se redondean a enteros. det(A-lambda*I) = (-1)^n p(lambda). Las raices se obtienen con polyroot y se conservan sin anular valores o componentes imaginarias pequenas. Las raices multiples pueden tener menor precision y partes imaginarias espurias; para el espectro numerico se recomienda valores_vectores_propios. El calculo de coeficientes puede perder precision por cancelacion en matrices mal escaladas y no es una herramienta simbolica. El desbordamiento produce Error.}
\examples{
A <- matrix(c(4,1,2,3),2,byrow=TRUE)
polinomio_caracteristico(A)
polinomio_caracteristico(matrix(c(5,4,2, 4,5,2, 2,2,2), 3, byrow=TRUE))$polinomio
}
\seealso{\code{\link{valores_vectores_propios}}, \code{\link{analisisnumerico-package}}}
