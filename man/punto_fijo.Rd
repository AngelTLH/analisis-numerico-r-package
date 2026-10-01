\name{punto_fijo}
\alias{punto_fijo}
\title{Iteracion de punto fijo}
\description{Itera x siguiente = g(x) hasta que el cambio sea menor que tol.}
\usage{
punto_fijo(g, x0, tol = 1e-6, max_iter = 100, mostrar = FALSE)
}
\arguments{
\item{g}{Funcion de iteracion que devuelve un unico real finito.}
\item{x0}{Punto inicial real finito.}
\item{tol}{Tolerancia real finita positiva para abs(x siguiente - x anterior).}
\item{max_iter}{Limite entero positivo de iteraciones; puede detenerse antes si cumple la tolerancia.}
\item{mostrar}{Logico. TRUE imprime x, x siguiente y el cambio en cada iteracion.}
}
\value{Lista: raiz, iter, error = abs(x siguiente-x anterior), convergencia (logico) e historial (iter, x, x_siguiente, error).}
\details{El usuario elige g y un punto inicial apropiado; no se comprueba automaticamente la contraccion. Al agotar max_iter devuelve la ultima aproximacion con convergencia=FALSE y una advertencia.}
\examples{
punto_fijo(function(x) sqrt(x+2), 1)
}
\seealso{\code{\link{analisisnumerico-package}}}
