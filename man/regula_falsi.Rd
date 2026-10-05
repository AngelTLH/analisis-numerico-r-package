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
\item{tol}{Tolerancia real finita positiva. Su significado se explica en Valor y Detalles.}
\item{max_iter}{Limite entero positivo de iteraciones; puede detenerse antes si cumple la tolerancia.}
\item{mostrar}{Logico. TRUE imprime los pasos; FALSE mantiene silencio. Consulte el comportamiento al agotar iteraciones en Detalles.}
}
\value{Lista: raiz, iter, error = abs(f(raiz)), convergencia e historial, disponible tambien con mostrar=FALSE.}
\details{f debe ser continua. Se rechazan raices en los extremos por la convencion estricta de clase. Un residuo pequeno no garantiza una cota del error en x. Se detiene cuando abs(f(c)) es menor que tol. Con mostrar=TRUE se imprimen los valores y la decision de actualizar a o b; no obliga a ejecutar max_iter pasos. Al agotar el limite, mostrar=TRUE advierte y retorna convergencia=FALSE; mostrar=FALSE produce Error. Los resultados que cumplen el criterio incluyen convergencia=TRUE. Las entradas invalidas y el estancamiento numerico producen Error en ambos modos. Historial: iter, a, b, c, f_c, error.}
\examples{
f <- function(x) x^3-x-2
r <- regula_falsi(f, 1, 2)
r$raiz
regula_falsi(f, 1, 2, max_iter=4, mostrar=TRUE)
}
\seealso{\code{\link{analisisnumerico-package}}}
