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
\item{tol}{Tolerancia real finita positiva para el semiancho del intervalo.}
\item{max_iter}{Limite entero positivo de iteraciones; puede detenerse antes si cumple la tolerancia.}
\item{mostrar}{Logico. TRUE imprime a, b, c y f(c) en cada iteracion.}
}
\value{Lista: raiz, iter, error (semiancho del intervalo; cero si f(c)=0), residuo = abs(f(c)), convergencia (logico) e historial (iter, a, b, c, f_c, error).}
\details{Requiere continuidad y cambio de signo estricto. Se detiene por semiancho menor que tol o raiz exacta. Al agotar max_iter devuelve la ultima aproximacion con convergencia=FALSE y una advertencia; para un numero fijo de pasos use max_iter con una tol pequena. La impresion muestra a, b, c y f(c) antes de actualizar el intervalo.}
\examples{
biseccion(function(x) x^2-2, 1, 2)
}
\seealso{\code{\link{regula_falsi}}, \code{\link{analisisnumerico-package}}}
