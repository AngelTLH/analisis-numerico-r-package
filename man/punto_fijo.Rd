\name{punto_fijo}
\alias{punto_fijo}
\title{Iteracion de punto fijo}
\description{Itera x siguiente = g(x) hasta que el cambio sea menor que tol.}
\usage{
punto_fijo(g, x0, tol = 1e-6, max_iter = 100, mostrar = FALSE)
}
\arguments{
\item{g}{Funcion de iteracion que devuelve un unico real finito.}
\item{x0}{Punto inicial real en punto fijo; vector real no nulo en potencia. NULL en potencia usa un vector de unos.}
\item{tol}{Tolerancia real finita positiva. Su significado se explica en Valor y Detalles.}
\item{max_iter}{Limite entero positivo de iteraciones; puede detenerse antes si cumple la tolerancia.}
\item{mostrar}{Logico. TRUE imprime los pasos; FALSE mantiene silencio. Consulte el comportamiento al agotar iteraciones en Detalles.}
}
\value{Lista: raiz, iter, error = abs(x siguiente-x anterior), historial.}
\details{El usuario elige g y un punto inicial apropiado; no se comprueba automaticamente la contraccion. El historial contiene iter, x, x_siguiente, error. Con mostrar=TRUE se detiene igualmente al cumplir tol; no obliga a ejecutar max_iter pasos. Al agotar el limite retorna la ultima aproximacion con convergencia=FALSE; con mostrar=FALSE emite Error. Las salidas exitosas actuales no incluyen el campo convergencia. Los errores de entradas siguen deteniendo la llamada en ambos modos.}
\examples{
punto_fijo(function(x) sqrt(x+2), 1)
}
\seealso{\code{\link{analisisnumerico-package}}}

