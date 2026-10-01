\name{valores_vectores_propios}
\alias{valores_vectores_propios}
\title{Valores y vectores propios}
\description{Calcula el espectro con eigen de R base y permite elegir la escala de los vectores.}
\usage{
valores_vectores_propios(A, escala = c("l2", "pivote", "max"))
}
\arguments{
\item{A}{Matriz numerica cuadrada finita no vacia, real o compleja.}
\item{escala}{Escala de cada vector propio: "l2" unitario (salida de eigen), "pivote" primera componente no nula igual a 1, "max" componente de mayor modulo igual a 1.}
}
\value{Lista: valores (reales o complejos), vectores (autovectores por columnas, en el mismo orden).}
\details{Las escalas "pivote" y "max" eliminan restos de redondeo y partes imaginarias nulas. Para autovalores multiples los vectores de eigen pueden ser casi dependientes; use espacio_propio para obtener una base del espacio propio.}
\examples{
A <- matrix(c(4,1,2,3),2,byrow=TRUE)
valores_vectores_propios(A, escala="pivote")
valores_vectores_propios(matrix(c(0,-1,1,0),2,byrow=TRUE))
}
\seealso{\code{\link{espacio_propio}}, \code{\link{polinomio_caracteristico}}, \code{\link{analisisnumerico-package}}}
