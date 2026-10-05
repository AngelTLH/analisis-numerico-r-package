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
\item{tol}{Tolerancia real finita positiva. Su significado se explica en Valor y Detalles.}
\item{max_iter}{Limite entero positivo de iteraciones; puede detenerse antes si cumple la tolerancia.}
\item{mostrar}{Logico. TRUE imprime los pasos; FALSE mantiene silencio. Consulte el comportamiento al agotar iteraciones en Detalles.}
}
\value{Lista: raiz, iter, error = abs(x siguiente-x anterior), convergencia e historial.}
\details{El usuario elige g y un punto inicial apropiado; no se comprueba automaticamente la contraccion ni la equivalencia con una ecuacion f(x)=0. Un cambio pequeno no es una cota certificada de distancia al punto fijo. El historial siempre contiene iter, x, x_siguiente, error. Se detiene al cumplir el criterio de cambio absoluto, incluso con mostrar=TRUE. Al agotar el limite, mostrar=TRUE advierte y retorna convergencia=FALSE; mostrar=FALSE produce Error. Los resultados que cumplen el criterio incluyen convergencia=TRUE. Las entradas invalidas producen Error en ambos modos.}
\examples{
punto_fijo(function(x) sqrt(x+2), 1)
}
\seealso{\code{\link{analisisnumerico-package}}}
