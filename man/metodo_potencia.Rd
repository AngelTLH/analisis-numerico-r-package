\name{metodo_potencia}
\alias{metodo_potencia}
\title{Metodo de la potencia}
\description{Aproxima un par propio mediante multiplicaciones sucesivas.}
\usage{
metodo_potencia(A, x0 = NULL, tol = 1e-6, max_iter = 100,
                            normalizar = c("l2", "inf"), mostrar = FALSE)
}
\arguments{
\item{A}{Matriz numerica finita no vacia; consulte las restricciones en Detalles.}
\item{x0}{Punto inicial real en punto fijo; vector real no nulo en potencia. NULL en potencia usa un vector de unos.}
\item{tol}{Tolerancia real finita positiva. Su significado se explica en Valor y Detalles.}
\item{max_iter}{Limite entero positivo de iteraciones; puede detenerse antes si cumple la tolerancia.}
\item{normalizar}{Norma de normalizacion: "l2" euclidiana o "inf" infinito.}
\item{mostrar}{Logico. TRUE imprime los pasos; FALSE mantiene silencio. Consulte el comportamiento al agotar iteraciones en Detalles.}
}
\value{Lista: valor, vector, iter, error = max(abs(A \%*\% vector-valor*vector)).}
\details{Requiere A real y un vector inicial con componente en la direccion buscada. El residuo pequeno no certifica que el autovalor sea dominante. Se rechaza un vector generado nulo. Con mostrar=TRUE se detiene igualmente al cumplir tol; no obliga a ejecutar max_iter pasos. Al agotar el limite retorna la ultima aproximacion con convergencia=FALSE; con mostrar=FALSE emite Error. Las salidas exitosas actuales no incluyen el campo convergencia. Los errores de entradas siguen deteniendo la llamada en ambos modos. Imprime valor y residuo por paso; no devuelve historial.}
\examples{
A <- matrix(c(4,1,2,3),2,byrow=TRUE)
metodo_potencia(A, c(1,0))
}
\seealso{\code{\link{analisisnumerico-package}}}

