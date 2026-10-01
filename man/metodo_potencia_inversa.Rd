\name{metodo_potencia_inversa}
\alias{metodo_potencia_inversa}
\title{Metodo de la potencia inversa}
\description{Resuelve sistemas con A-mu*I para aproximar el autovalor mas cercano a mu.}
\usage{
metodo_potencia_inversa(A, x0 = NULL, desplazamiento = 0,
                        tol = 1e-6, max_iter = 100, mostrar = FALSE)
}
\arguments{
\item{A}{Matriz real cuadrada finita no vacia.}
\item{x0}{Vector inicial real no nulo de longitud nrow(A). NULL usa un vector de unos.}
\item{desplazamiento}{Escalar real finito mu que define A-mu*I.}
\item{tol}{Tolerancia real finita positiva para el residuo max(abs(A \%*\% x - valor*x)).}
\item{max_iter}{Limite entero positivo de iteraciones; puede detenerse antes si cumple la tolerancia.}
\item{mostrar}{Logico. TRUE imprime y, x, valor y residuo de cada iteracion.}
}
\value{Lista: valor, vector, iter, error (residuo), convergencia (logico) e historial, un data frame con iter, y1..yn (solucion del sistema), x1..xn (y normalizado en norma euclidiana), valor y error.}
\details{En cada iteracion se resuelve (A-mu*I) y = x con solve de R base, se normaliza y y valor es el cociente de Rayleigh de x respecto de A, es decir, una aproximacion directa del autovalor de A. A-mu*I debe ser numericamente invertible. Con mu=0 busca el autovalor de menor modulo. Al agotar max_iter devuelve la ultima aproximacion con convergencia=FALSE y una advertencia.}
\examples{
A <- matrix(c(4,1,2,3),2,byrow=TRUE)
metodo_potencia_inversa(A, c(1,0))
metodo_potencia_inversa(A, desplazamiento=4.8)$valor
}
\seealso{\code{\link{metodo_potencia}}, \code{\link{analisisnumerico-package}}}
