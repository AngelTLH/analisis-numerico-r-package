\name{algoritmo_qr}
\alias{algoritmo_qr}
\title{Iteracion QR para espectro real}
\description{Repite factorizaciones QR y actualizaciones RQ sin desplazamiento.}
\usage{
algoritmo_qr(A, tol = 1e-8, max_iter = 1000)
}
\arguments{
\item{A}{Matriz numerica finita no vacia; consulte las restricciones en Detalles.}
\item{tol}{Tolerancia real finita positiva. Su significado se explica en Valor y Detalles.}
\item{max_iter}{Limite entero positivo de iteraciones; puede detenerse antes si cumple la tolerancia.}
}
\value{Lista: valores = diagonal final, iter, error = maximo absoluto bajo la diagonal.}
\details{Requiere matriz real cuadrada. Solo retorna al alcanzar una parte inferior menor que tol. Puede no converger, incluso con espectro real; bloques complejos no se resuelven. No tiene argumento mostrar.}
\examples{
A <- matrix(c(6,2,2,3),2)
algoritmo_qr(A)
}
\seealso{\code{\link{analisisnumerico-package}}}

