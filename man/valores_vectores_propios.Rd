\name{valores_vectores_propios}
\alias{valores_vectores_propios}
\title{Valores y vectores propios}
\description{Calcula el espectro con eigen de R base.}
\usage{
valores_vectores_propios(A)
}
\arguments{
\item{A}{Matriz numerica finita no vacia; consulte las restricciones en Detalles.}
}
\value{Lista: valores (reales o complejos), vectores (autovectores por columnas, en el mismo orden).}
\details{Acepta matrices cuadradas reales o complejas.}
\examples{
A <- matrix(c(0,-1,1,0),2,byrow=TRUE)
valores_vectores_propios(A)
}
\seealso{\code{\link{analisisnumerico-package}}}

