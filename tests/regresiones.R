library(analisisnumerico)

# Resultados pequenos no deben desaparecer por el formato de impresion.
A <- matrix(c(2,0,1e-13,1),2,byrow=TRUE)
r <- valores_vectores_propios(A,escala="max")
stopifnot(abs(r$vectores[2,which.max(r$valores)]-1e-13) < 1e-15)
r <- polinomio_caracteristico(diag(c(1,1e-13)))
stopifnot(min(Mod(r$raices-1e-13)) < 1e-15)
A <- 1e-16*matrix(c(0,-1,1,0),2,byrow=TRUE)
r <- polinomio_caracteristico(A)
stopifnot(min(Mod(r$raices-1e-16i)) < 1e-25,
          min(Mod(r$raices+1e-16i)) < 1e-25)

# La dimension del nucleo y las multiplicidades no dependen de la escala.
for (factor in c(1e-16,1,1e16)) {
  A <- factor*diag(c(2,3))
  r <- espacio_propio(A,2*factor)
  stopifnot(r$dimension == 1)
  r <- multiplicidad_espectral(A)
  stopifnot(nrow(r)==2,all(r$algebraica==1),all(r$geometrica==1))
}

# QR y semejanza conservan los datos de una matriz diminuta.
A <- 1e-16*matrix(c(2,1,1,3),2)
r <- descomposicion_qr(A)
stopifnot(max(abs(r$Q%*%r$R-A))/max(abs(A)) < 1e-10)
A <- 1e-16*matrix(c(1,2,0,0,2,3,4,0,3),3,byrow=TRUE)
r <- householder_reduction(A)
stopifnot(r$forma=="Hessenberg",
  max(abs(r$T-t(r$Q)%*%A%*%r$Q))/max(abs(A)) < 1e-10)
r <- reflector_householder(c(1,1e-200),signo="-")
stopifnot(all(is.finite(r$H)),max(abs(t(r$H)%*%r$H-diag(2))) < 1e-10)

# Resultados de clase y errores que anteriormente podian ocultarse.
r <- secante(function(x) x^2-2,1,2)
stopifnot(abs(r$raiz-sqrt(2)) < 1e-8,
  max(abs(r$historial$x2[1:2]-c(4/3,7/5))) < 1e-14)
r <- algoritmo_qr(diag(c(0,2)))
stopifnot(max(abs(sort(r$valores)-c(0,2))) < 1e-10)
cat("Regresiones de escala y ejemplos de clase: OK.\n")
