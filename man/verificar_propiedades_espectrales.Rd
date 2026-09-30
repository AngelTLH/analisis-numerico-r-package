\name{verificar_propiedades_espectrales}
\alias{verificar_propiedades_espectrales}
\title{Comprobaciones espectrales}
\description{Compara numericamente traza, determinante, transpuesta, potencias, desplazamiento e inversa.}
\usage{
verificar_propiedades_espectrales(A, k = 3, c_escalar = 2, tol = 1e-6)
}
\arguments{
\item{A}{Matriz numerica finita no vacia; consulte las restricciones en Detalles.}
\item{k}{Exponente entero no negativo.}
\item{c_escalar}{Escalar real finito para A+c_escalar*I.}
\item{tol}{Tolerancia real finita positiva. Su significado se explica en Valor y Detalles.}
}
\value{Data frame: propiedad y cumple. Inversa es NA cuando solve no puede invertir A.}
\details{Conserva signos y partes imaginarias al comparar espectros. Los resultados verifican ejemplos y no demuestran teoremas generales. k=0 utiliza la identidad.}
\examples{
A <- matrix(c(4,1,2,3),2,byrow=TRUE)
verificar_propiedades_espectrales(A, k=0)
}
\seealso{\code{\link{analisisnumerico-package}}}

