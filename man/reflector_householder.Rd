\name{reflector_householder}
\alias{reflector_householder}
\title{Reflector de Householder}
\description{Construye una reflexion que anula componentes posteriores a la primera.}
\usage{
reflector_householder(x)
}
\arguments{
\item{x}{Vector numerico finito; consulte las restricciones en Detalles.}
}
\value{Lista: v unitario y H = I-2*v*t(v). Para x nulo, v=0 y H=I.}
\details{x debe ser real, finito y no vacio. Se admite el vector nulo.}
\examples{
r <- reflector_householder(c(3,4))
r$H \%*\% c(3,4)
}
\seealso{\code{\link{analisisnumerico-package}}}

