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
\value{Lista: raiz, iter, error (semiancho del intervalo; cero si f(c)=0), residuo = abs(f(c)), convergencia e historial.}
\details{Requiere continuidad y cambio de signo estricto. Se detiene por semiancho menor que tol o raiz exacta. El historial siempre contiene iter, a, b, c, f_c, error. Con mostrar=TRUE imprime cada paso y la decision de actualizar a o b; no obliga a ejecutar max_iter pasos. Al agotar el limite, mostrar=TRUE advierte y retorna convergencia=FALSE; mostrar=FALSE produce Error. Los resultados que cumplen el criterio incluyen convergencia=TRUE. Las entradas invalidas y el estancamiento producen Error en ambos modos.}
\examples{
biseccion(function(x) x^2-2, 1, 2)
}
\seealso{\code{\link{analisisnumerico-package}}}
