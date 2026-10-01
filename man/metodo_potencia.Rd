\name{metodo_potencia}
\alias{metodo_potencia}
\title{Metodo de la potencia}
\description{Aproxima el par propio dominante mediante multiplicaciones sucesivas y el cociente de Rayleigh.}
\usage{
metodo_potencia(A, x0 = NULL, tol = 1e-6, max_iter = 100,
                normalizar = c("l2", "inf"), mostrar = FALSE)
}
\arguments{
\item{A}{Matriz real cuadrada finita no vacia.}
\item{x0}{Vector inicial real no nulo de longitud nrow(A). NULL usa un vector de unos.}
\item{tol}{Tolerancia real finita positiva para el residuo max(abs(A \%*\% x - valor*x)).}
\item{max_iter}{Limite entero positivo de iteraciones; puede detenerse antes si cumple la tolerancia.}
\item{normalizar}{Norma de normalizacion de cada iterado: "l2" euclidiana o "inf" (componente de mayor modulo igual a 1 en valor absoluto).}
\item{mostrar}{Logico. TRUE imprime y, x, valor y residuo de cada iteracion.}
}
\value{Lista: valor, vector, iter, error (residuo), convergencia (logico) e historial, un data frame con iter, y1..yn (y = A x anterior), x1..xn (y normalizado), valor y error.}
\details{En cada iteracion y = A x, x = y normalizado y valor = cociente de Rayleigh de x. Para ejecutar un numero fijo de iteraciones use max_iter con una tol pequena: al agotar max_iter devuelve la ultima aproximacion con convergencia=FALSE y una advertencia. Requiere un vector inicial con componente en la direccion dominante. Si hay dos autovalores dominantes de igual modulo la sucesion puede oscilar sin converger. El residuo pequeno no certifica que el autovalor sea dominante.}
\examples{
A <- matrix(c(4,1,2,3),2,byrow=TRUE)
metodo_potencia(A, c(1,0))
r <- metodo_potencia(A, c(1,0), tol=1e-12, max_iter=4)
r$historial
}
\seealso{\code{\link{metodo_potencia_inversa}}, \code{\link{cociente_rayleigh}}, \code{\link{analisisnumerico-package}}}
