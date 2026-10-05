\name{secante}
\alias{secante}
\title{Raices por el metodo de la secante}
\description{Aproxima una raiz usando los dos puntos mas recientes, sin derivadas ni requisito de signos opuestos.}
\usage{
secante(f, x0, x1, tol = 1e-8, max_iter = 100, mostrar = FALSE)
}
\arguments{
\item{f}{Funcion de una variable que devuelve un unico real finito.}
\item{x0}{Primera aproximacion real finita.}
\item{x1}{Segunda aproximacion real finita, distinta de x0.}
\item{tol}{Tolerancia positiva sobre el cambio absoluto entre aproximaciones.}
\item{max_iter}{Maximo entero positivo de nuevas aproximaciones.}
\item{mostrar}{Logico: imprime cada paso. Al agotar max_iter, TRUE advierte y devuelve el ultimo resultado; FALSE produce Error.}
}
\value{Lista con raiz, iter, error (cambio absoluto del ultimo paso), residuo = abs(f(raiz)), convergencia e historial. El historial siempre contiene iter, x0, x1, x2, f_x2 y error. Una raiz exacta inicial retorna iter = 0 e historial vacio.}
\details{
Implementa x2 = x1 - f(x1) * (x1-x0) / (f(x1)-f(x0)), como en la diapositiva 16 del material de Secante del profesor. Solo realiza una nueva evaluacion de f por iteracion, conservando las dos anteriores.
El denominador se calcula con valores de f escalados para evitar desbordamiento; valores indistinguibles a precision de maquina producen Error.
Se detiene si el cambio absoluto es menor que tol o si f(x2) es exactamente cero. Un paso pequeno no garantiza una cota de distancia a la raiz; se devuelve el residuo para revisarlo. Se rechaza el estancamiento numerico con residuo mayor o igual a tol. La convergencia es local y depende de los puntos iniciales y de f.
}
\examples{
r <- secante(function(x) x^2 - 2, 1, 2, mostrar = TRUE)
r$historial
r$residuo
secante(function(x) cos(x) - x, 0, 1)
}
\seealso{\code{\link{grafico_secante}}, \code{\link{regula_falsi}}}
