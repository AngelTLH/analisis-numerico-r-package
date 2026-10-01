\name{reflector_householder}
\alias{reflector_householder}
\title{Reflector de Householder}
\description{Construye una reflexion que anula componentes posteriores a la primera.}
\usage{
reflector_householder(x, signo = c("+", "-"))
}
\arguments{
\item{x}{Vector real finito no vacio.}
\item{signo}{"+" usa v = x + sign(x1)*||x||*e1, de modo que H x = -sign(x1)*||x||*e1. "-" usa v = x - sign(x1)*||x||*e1, de modo que H x = sign(x1)*||x||*e1.}
}
\value{Lista: v unitario y H = I-2*v*t(v). Para x nulo, v=0 y H=I.}
\details{Se toma sign(0) = 1, de modo que el reflector siempre anula las componentes posteriores. Con signo "-" la primera componente de v se calcula con una formula equivalente que evita la cancelacion; si x ya es multiplo de e1, v=0 y H=I. Se admite el vector nulo.}
\examples{
r <- reflector_householder(c(3,4))
r$H \%*\% c(3,4)
reflector_householder(c(1,1,1,1), signo="-")$H \%*\% c(1,1,1,1)
}
\seealso{\code{\link{householder_qr}}, \code{\link{householder_reduction}}, \code{\link{analisisnumerico-package}}}
