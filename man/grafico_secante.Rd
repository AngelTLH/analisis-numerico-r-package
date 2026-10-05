\name{grafico_secante}
\alias{grafico_secante}
\title{Evolucion geometrica del metodo de la secante}
\description{Dibuja paneles sucesivos con la curva, los puntos usados y las secantes acumuladas, como en la diapositiva 6 del material del profesor.}
\usage{
grafico_secante(f = function(x) x^3 - x - 1, x0 = 0.5, x1 = 2,
  iteraciones = 6, xlim = c(-1, 3), ylim = c(-4, 10), n = 500)
}
\arguments{
\item{f}{Funcion de una variable, no necesariamente vectorizada, que devuelve un real finito.}
\item{x0}{Primera aproximacion real finita.}
\item{x1}{Segunda aproximacion real finita, distinta de x0.}
\item{iteraciones}{Numero entero positivo de paneles. Se detiene antes si encuentra una raiz exacta.}
\item{xlim}{Dos reales finitos crecientes: limites horizontales.}
\item{ylim}{Dos reales finitos crecientes: limites verticales.}
\item{n}{Numero entero de puntos de la curva, al menos 2.}
}
\value{Devuelve invisiblemente una lista con historial (iter, x0, x1, x2, f_x2, error) y puntos (x, f_x), incluidos los iniciales. Dibuja sobre el dispositivo grafico activo y restaura sus parametros al terminar.}
\details{
Por defecto reproduce los seis paneles de la diapositiva 6: f(x) = x^3-x-1, x0 = 0.5, x1 = 2, ejes x entre -1 y 3 e y entre -4 y 10. La curva es azul y los puntos y secantes son rojos. Los paneles muestran acumulativamente las secantes utilizadas en las iteraciones 1 a 6. El nuevo corte con el eje x permite localizar la siguiente aproximacion.
Esta es una visualizacion geometrica, no un grafico del error frente al numero de iteraciones. No implementa Illinois ni Steffensen.
No usa tolerancia para detenerse: ejecuta los pasos solicitados salvo raiz exacta. Dos valores iniciales que sean raices, un denominador indistinguible de cero, el estancamiento o valores no finitos producen Error.
Los limites son fijos; al cambiar la funcion o los puntos, ajuste xlim e ylim para evitar recortes. Para guardar, abra un dispositivo png() o pdf(), llame a esta funcion y cierre con dev.off().
}
\examples{
datos <- grafico_secante()
datos$historial
grafico_secante(function(x) x^2 - 2, 1, 2, iteraciones = 3,
                 xlim = c(0, 2.5), ylim = c(-2, 5))
}
\seealso{\code{\link{secante}}}
