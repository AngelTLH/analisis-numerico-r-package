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
\item{x0}{Vector real finito no nulo de longitud nrow(A); NULL usa un vector de unos.}
\item{tol}{Tolerancia real finita positiva. Su significado se explica en Valor y Detalles.}
\item{max_iter}{Limite entero positivo de iteraciones; puede detenerse antes si cumple la tolerancia.}
\item{normalizar}{Norma de normalizacion: "l2" euclidiana o "inf" infinito.}
\item{mostrar}{Logico. TRUE imprime los pasos; FALSE mantiene silencio. Consulte el comportamiento al agotar iteraciones en Detalles.}
}
\value{Lista: valor (cociente de Rayleigh), vector, iter, error = max(abs(A \%*\% vector-valor*vector)), convergencia e historial. El historial contiene iter, componentes de y y x, valor y error.}
\details{Requiere A real cuadrada y un vector inicial con componente en la direccion buscada. La convergencia hacia el dominante necesita separacion de modulos; un residuo pequeno certifica un par propio aproximado, pero no que sea el dominante. Se rechaza un vector generado nulo. El criterio es el residuo absoluto, no el cambio de Rayleigh. Con mostrar=TRUE imprime y, x, valor y residuo; se detiene igualmente al cumplir tol. Al agotar max_iter, mostrar=TRUE advierte y retorna convergencia=FALSE; mostrar=FALSE produce Error. Los resultados que cumplen el criterio incluyen convergencia=TRUE y el historial esta disponible en ambos modos.}
\examples{
A <- matrix(c(4,1,2,3),2,byrow=TRUE)
metodo_potencia(A, c(1,0))
}
\seealso{\code{\link{analisisnumerico-package}}}
