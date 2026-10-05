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
\item{x0}{Vector real finito no nulo de longitud nrow(A); NULL usa un vector de unos.}
\item{desplazamiento}{Escalar real finito mu que define A-mu*I.}
\item{tol}{Tolerancia real finita positiva. Su significado se explica en Valor y Detalles.}
\item{max_iter}{Limite entero positivo de iteraciones; puede detenerse antes si cumple la tolerancia.}
\item{mostrar}{Logico. TRUE imprime los pasos; FALSE mantiene silencio. Consulte el comportamiento al agotar iteraciones en Detalles.}
}
\value{Lista: valor (Rayleigh respecto de A), vector, iter, error (residuo absoluto del par), convergencia e historial. El historial contiene iter, componentes de y y x, valor y error.}
\details{A debe ser real cuadrada y A-mu*I numericamente invertible. Resuelve (A-mu*I)y=x con solve de R base y normaliza y. Con mu=0 busca el menor modulo bajo los supuestos de convergencia y un inicio apropiado. Un residuo pequeno no certifica que sea el par mas cercano al desplazamiento si el inicio carece de la componente necesaria. Con mostrar=TRUE imprime y, x, valor y residuo; se detiene igualmente al cumplir tol. Al agotar max_iter, mostrar=TRUE advierte y retorna convergencia=FALSE; mostrar=FALSE produce Error. Los resultados que cumplen el criterio incluyen convergencia=TRUE y el historial esta disponible en ambos modos.}
\examples{
A <- matrix(c(4,1,2,3),2,byrow=TRUE)
metodo_potencia_inversa(A, c(1,0))
}
\seealso{\code{\link{analisisnumerico-package}}}
