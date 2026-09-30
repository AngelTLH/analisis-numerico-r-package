\name{biseccion}
\alias{biseccion}
\title{Raices por biseccion}
\description{Divide un intervalo con cambio de signo por la mitad.}
\usage{
biseccion(f, a, b, tol = 1e-6, max_iter = 100, mostrar = FALSE)
}
\arguments{
\item{f}{Funcion continua en [a,b] que devuelve un unico real finito.}
\item{a}{Extremo inferior real finito.}
\item{b}{Extremo superior real finito; debe ser mayor que a.}
\item{tol}{Tolerancia real finita positiva. Su significado se explica en Valor y Detalles.}
\item{max_iter}{Limite entero positivo de iteraciones; puede detenerse antes si cumple la tolerancia.}
\item{mostrar}{Logico. TRUE imprime los pasos; FALSE mantiene silencio. Consulte el comportamiento al agotar iteraciones en Detalles.}
}
\value{Lista: raiz, iter, error (semiancho del intervalo; cero si f(c)=0), residuo = abs(f(c)), historial.}
\details{Requiere continuidad y cambio de signo estricto. Se detiene por semiancho menor que tol o raiz exacta. El historial contiene iter, a, b, c, f_c, error. Con mostrar=TRUE se detiene igualmente al cumplir tol; no obliga a ejecutar max_iter pasos. Al agotar el limite retorna la ultima aproximacion con convergencia=FALSE; con mostrar=FALSE emite Error. Las salidas exitosas actuales no incluyen el campo convergencia. Los errores de entradas siguen deteniendo la llamada en ambos modos. La impresion muestra a, b, c y f(c) antes de actualizar el intervalo; no imprime explicitamente la decision de actualizar a o b.}
\examples{
biseccion(function(x) x^2-2, 1, 2)
}
\seealso{\code{\link{analisisnumerico-package}}}

