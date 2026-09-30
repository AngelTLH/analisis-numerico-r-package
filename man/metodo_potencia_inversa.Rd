\name{metodo_potencia_inversa}
\alias{metodo_potencia_inversa}
\title{Metodo de la potencia inversa}
\description{Resuelve sistemas con A-mu*I para aproximar el autovalor mas cercano a mu.}
\usage{
metodo_potencia_inversa(A, x0 = NULL, desplazamiento = 0,
                                    tol = 1e-6, max_iter = 100, mostrar = FALSE)
}
\arguments{
\item{A}{Matriz numerica finita no vacia; consulte las restricciones en Detalles.}
\item{x0}{Punto inicial real en punto fijo; vector real no nulo en potencia. NULL en potencia usa un vector de unos.}
\item{desplazamiento}{Escalar real finito mu que define A-mu*I.}
\item{tol}{Tolerancia real finita positiva. Su significado se explica en Valor y Detalles.}
\item{max_iter}{Limite entero positivo de iteraciones; puede detenerse antes si cumple la tolerancia.}
\item{mostrar}{Logico. TRUE imprime los pasos; FALSE mantiene silencio. Consulte el comportamiento al agotar iteraciones en Detalles.}
}
\value{Lista: valor, vector, iter, error (residuo absoluto del par).}
\details{A debe ser real y A-mu*I numericamente invertible. Utiliza solve de R base. Con mu=0 busca el menor modulo bajo los supuestos de convergencia y un inicio apropiado. Con mostrar=TRUE se detiene igualmente al cumplir tol; no obliga a ejecutar max_iter pasos. Al agotar el limite retorna la ultima aproximacion con convergencia=FALSE; con mostrar=FALSE emite Error. Las salidas exitosas actuales no incluyen el campo convergencia. Los errores de entradas siguen deteniendo la llamada en ambos modos. Imprime valor y residuo por paso; no devuelve historial.}
\examples{
A <- matrix(c(4,1,2,3),2,byrow=TRUE)
metodo_potencia_inversa(A, c(1,0))
}
\seealso{\code{\link{analisisnumerico-package}}}

