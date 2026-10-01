\name{regula_falsi}
\alias{regula_falsi}
\title{Raices por Regula Falsi}
\description{Busca una raiz por interpolacion entre extremos con signos opuestos.}
\usage{
regula_falsi(f, a, b, tol = 1e-6, max_iter = 100, mostrar = FALSE)
}
\arguments{
\item{f}{Funcion continua en [a,b] que devuelve un unico real finito.}
\item{a}{Extremo inferior real finito.}
\item{b}{Extremo superior real finito; debe ser mayor que a.}
\item{tol}{Tolerancia real finita positiva para abs(f(c)).}
\item{max_iter}{Limite entero positivo de iteraciones; puede detenerse antes si cumple la tolerancia.}
\item{mostrar}{Logico. TRUE imprime a, b, c y f(c) en cada iteracion.}
}
\value{Lista: raiz, iter, error = abs(f(raiz)), convergencia (logico) e historial (iter, a, b, c, f_c, error).}
\details{Se exige cambio de signo estricto: un extremo con f igual a cero se rechaza. Un residuo pequeno no garantiza una cota del error en x. Al agotar max_iter devuelve la ultima aproximacion con convergencia=FALSE y una advertencia; para un numero fijo de pasos use max_iter con una tol pequena. La impresion muestra a, b, c y f(c) antes de actualizar el intervalo.}
\examples{
f <- function(x) x^3-x-2
r <- regula_falsi(f, 1, 2)
r$raiz
regula_falsi(f, 1, 2, tol=1e-12, max_iter=4)$historial
}
\seealso{\code{\link{biseccion}}, \code{\link{analisisnumerico-package}}}
