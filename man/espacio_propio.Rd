\name{espacio_propio}
\alias{espacio_propio}
\title{Base del espacio propio}
\description{Calcula una base del nucleo de A-lambda*I y su dimension (multiplicidad geometrica).}
\usage{
espacio_propio(A, lambda, tol = 1e-8, escala = c("pivote", "max", "l2"))
}
\arguments{
\item{A}{Matriz numerica cuadrada finita no vacia, real o compleja.}
\item{lambda}{Autovalor real o complejo finito.}
\item{tol}{Tolerancia positiva de rango despues de escalar juntos A y lambda por max(Mod(A),Mod(lambda)).}
\item{escala}{"pivote" base en forma escalonada reducida (la primera componente no nula de cada vector es 1), "max" componente de mayor modulo igual a 1, "l2" base ortonormal.}
}
\value{Lista: base (vectores por columnas) y dimension.}
\details{La dimension se obtiene por SVD del sistema escalado; el umbral es tol*max(1, valores singulares del sistema escalado). Escalar simultaneamente A y lambda no cambia el nucleo. Emite Error si lambda no es autovalor con esa tolerancia; un autovalor aproximado puede requerir una tol mayor. No se redondean las componentes de la base devuelta.}
\examples{
A <- matrix(c(4,1,2,3),2,byrow=TRUE)
espacio_propio(A, 2)
D <- matrix(c(5,4,2, 4,5,2, 2,2,2), 3, byrow=TRUE)
espacio_propio(D, 1)
}
\seealso{\code{\link{valores_vectores_propios}}, \code{\link{multiplicidad_espectral}}, \code{\link{analisisnumerico-package}}}
