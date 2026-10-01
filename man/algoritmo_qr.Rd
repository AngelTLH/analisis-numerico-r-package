\name{algoritmo_qr}
\alias{algoritmo_qr}
\title{Iteracion QR para espectro real}
\description{Repite factorizaciones QR y actualizaciones RQ sin desplazamiento.}
\usage{
algoritmo_qr(A, tol = 1e-8, max_iter = 1000)
}
\arguments{
\item{A}{Matriz real cuadrada finita no vacia.}
\item{tol}{Tolerancia real finita positiva para el maximo absoluto bajo la diagonal.}
\item{max_iter}{Limite entero positivo de iteraciones; puede detenerse antes si cumple la tolerancia.}
}
\value{Lista: valores = diagonal final, iter, error = maximo absoluto bajo la diagonal, convergencia (logico) y matriz (A_k final).}
\details{Al agotar max_iter devuelve la ultima iteracion con convergencia=FALSE y una advertencia. Con autovalores complejos, o con autovalores distintos de igual modulo, la iteracion no se triangulariza: quedan bloques 2x2 en matriz y la diagonal no contiene los autovalores. No tiene argumento mostrar.}
\examples{
A <- matrix(c(6,2,2,3),2)
algoritmo_qr(A)
}
\seealso{\code{\link{analisisnumerico-package}}}
