# Biblioteca para la evaluacion: autovalores y metodos posteriores.
# Cargar con source("analisis_numerico.R"). Solo utiliza R base.
# Las funciones detienen la llamada con stop() si no pueden resolverla.

# Validaciones compartidas -------------------------------------------------
.es_real <- function(x) is.numeric(x) && !is.complex(x)

.escalar <- function(x, nombre) {
  if (!.es_real(x) || length(x) != 1L || !is.finite(x))
    stop(paste(nombre, "debe ser un numero real finito."), call. = FALSE)
}

.tolerancia <- function(tol) {
  .escalar(tol, "tol")
  if (tol <= 0) stop("tol debe ser mayor que cero.", call. = FALSE)
}

.iteraciones <- function(tol, max_iter) {
  .tolerancia(tol)
  .escalar(max_iter, "max_iter")
  if (max_iter < 1 || max_iter != floor(max_iter))
    stop("max_iter debe ser un entero positivo.", call. = FALSE)
}

.matriz <- function(A, cuadrada = TRUE, real = FALSE) {
  if (!is.matrix(A) || !(is.numeric(A) || is.complex(A)) ||
      any(dim(A) == 0) || any(!is.finite(A)))
    stop("A debe ser una matriz numerica no vacia con valores finitos.", call. = FALSE)
  if (cuadrada && nrow(A) != ncol(A))
    stop("A debe ser cuadrada.", call. = FALSE)
  if (real && is.complex(A))
    stop("Este metodo requiere una matriz real.", call. = FALSE)
}

.vector <- function(x, n = length(x), real = FALSE) {
  if (!(is.numeric(x) || is.complex(x)) || !is.null(dim(x)) ||
      length(x) != n || n == 0 || any(!is.finite(x)))
    stop("El vector debe tener longitud compatible y valores numericos finitos.", call. = FALSE)
  if (real && is.complex(x)) stop("El vector debe ser real.", call. = FALSE)
  if (all(x == 0)) stop("El vector no puede ser nulo.", call. = FALSE)
}

.evaluar <- function(f, x) {
  y <- f(x)
  if (!.es_real(y) || length(y) != 1L || !is.finite(y))
    stop("La funcion debe devolver un unico numero real finito.", call. = FALSE)
  y
}

.mostrar <- function(mostrar) {
  if (!is.logical(mostrar) || length(mostrar) != 1L || is.na(mostrar))
    stop("mostrar debe ser TRUE o FALSE.", call. = FALSE)
}

.registrar <- function(mostrar, texto) {
  if (mostrar) cat(texto, "\n")
}

.intervalo <- function(f, a, b, tol, max_iter) {
  if (!is.function(f)) stop("f debe ser una funcion.", call. = FALSE)
  .escalar(a, "a")
  .escalar(b, "b")
  .iteraciones(tol, max_iter)
  if (a >= b) stop("El intervalo debe cumplir a < b.", call. = FALSE)
  fa <- .evaluar(f, a)
  fb <- .evaluar(f, b)
  # Equivale a f(a)*f(b) >= 0 sin multiplicar numeros de escalas extremas.
  if (fa == 0 || fb == 0 || sign(fa) == sign(fb))
    stop("El intervalo no cumple f(a)*f(b) < 0.", call. = FALSE)
  c(fa, fb)
}

.normalizar <- function(x, normalizar = "l2") {
  escala <- max(abs(x))
  if (!is.finite(escala) || escala == 0)
    stop("No se puede normalizar: vector nulo o no finito.", call. = FALSE)
  x <- x / escala
  if (normalizar == "l2") x <- x / sqrt(sum(Mod(x)^2))
  x
}

# Raices ------------------------------------------------------------------
# f debe ser continua en [a,b]. Se exige cambio de signo estricto como en clase.
# error es el residuo abs(f(c)); no es una cota de distancia a la raiz.
regula_falsi <- function(f, a, b, tol = 1e-6, max_iter = 100, mostrar = FALSE) {
  .mostrar(mostrar)
  extremos <- .intervalo(f, a, b, tol, max_iter)
  fa <- extremos[1]
  fb <- extremos[2]
  historial <- data.frame(iter = integer(), a = numeric(), b = numeric(),
                          c = numeric(), f_c = numeric(), error = numeric())
  for (k in seq_len(max_iter)) {
    # Interpolacion equivalente a (a*fb-b*fa)/(fb-fa), escalada.
    escala <- max(abs(fa), abs(fb))
    peso <- -(fa / escala) / (fb / escala - fa / escala)
    c <- (1 - peso) * a + peso * b
    fc <- .evaluar(f, c)
    error <- abs(fc)
    historial <- rbind(historial, data.frame(iter = k, a = a, b = b,
                                             c = c, f_c = fc, error = error))
    .registrar(mostrar, sprintf("Iteracion %d: a = %.10g, b = %.10g, c = %.10g, f(c) = %.10g",
                                k, a, b, c, fc))
    if (error < tol) return(list(raiz = c, iter = k, error = error,
                                 historial = if (mostrar) historial else NULL))
    if (c <= a || c >= b)
      stop("Regula Falsi se estanco por precision numerica.", call. = FALSE)
    if (sign(fa) != sign(fc)) {
      b <- c
      fb <- fc
    } else {
      a <- c
      fa <- fc
    }
  }
  if (mostrar) return(list(raiz = c, iter = max_iter, error = error,
                           convergencia = FALSE, historial = historial))
  stop("Regula Falsi no alcanzo la tolerancia en max_iter iteraciones.", call. = FALSE)
}

# error es la cota (b-a)/2; residuo es abs(f(c)). Parada por cota o raiz exacta.
biseccion <- function(f, a, b, tol = 1e-6, max_iter = 100, mostrar = FALSE) {
  .mostrar(mostrar)
  extremos <- .intervalo(f, a, b, tol, max_iter)
  fa <- extremos[1]
  historial <- data.frame(iter = integer(), a = numeric(), b = numeric(),
                          c = numeric(), f_c = numeric(), error = numeric())
  for (k in seq_len(max_iter)) {
    c <- a / 2 + b / 2
    fc <- .evaluar(f, c)
    error <- b / 2 - a / 2
    if (fc == 0) error <- 0
    historial <- rbind(historial, data.frame(iter = k, a = a, b = b,
                                             c = c, f_c = fc, error = error))
    .registrar(mostrar, sprintf("Iteracion %d: a = %.10g, b = %.10g, c = %.10g, f(c) = %.10g",
                                k, a, b, c, fc))
    if (error < tol)
      return(list(raiz = c, iter = k, error = error, residuo = abs(fc),
                  historial = if (mostrar) historial else NULL))
    if (c <= a || c >= b)
      stop("Biseccion se estanco por precision numerica.", call. = FALSE)
    if (sign(fa) != sign(fc)) {
      b <- c
    } else {
      a <- c
      fa <- fc
    }
  }
  if (mostrar) return(list(raiz = c, iter = max_iter, error = error,
                           residuo = abs(fc), convergencia = FALSE,
                           historial = historial))
  stop("Biseccion no alcanzo la tolerancia en max_iter iteraciones.", call. = FALSE)
}

# error es el cambio entre aproximaciones, como en el codigo de clase.
punto_fijo <- function(g, x0, tol = 1e-6, max_iter = 100, mostrar = FALSE) {
  .mostrar(mostrar)
  if (!is.function(g)) stop("g debe ser una funcion.", call. = FALSE)
  .escalar(x0, "x0")
  .iteraciones(tol, max_iter)
  historial <- data.frame(iter = integer(), x = numeric(), x_siguiente = numeric(), error = numeric())
  for (k in seq_len(max_iter)) {
    x1 <- .evaluar(g, x0)
    error <- abs(x1 - x0)
    historial <- rbind(historial, data.frame(iter = k, x = x0,
                                             x_siguiente = x1, error = error))
    .registrar(mostrar, sprintf("Iteracion %d: x = %.10g, x siguiente = %.10g, error = %.10g",
                                k, x0, x1, error))
    if (error < tol) return(list(raiz = x1, iter = k, error = error,
                                 historial = if (mostrar) historial else NULL))
    x0 <- x1
  }
  if (mostrar) return(list(raiz = x0, iter = max_iter, error = error,
                           convergencia = FALSE, historial = historial))
  stop("Punto fijo no alcanzo la tolerancia en max_iter iteraciones.", call. = FALSE)
}

# Autovalores y potencia ---------------------------------------------------
cociente_rayleigh <- function(A, x) {
  .matriz(A)
  .vector(x, nrow(A))
  x <- .normalizar(x)
  valor <- sum(Conj(x) * as.vector(A %*% x)) / sum(Mod(x)^2)
  if (!is.finite(valor)) stop("El cociente de Rayleigh no es finito.", call. = FALSE)
  valor
}

# error = max(abs(A*x-lambda*x)), residuo absoluto del par aproximado.
# Requiere los supuestos de potencia; el residuo no certifica dominancia.
metodo_potencia <- function(A, x0 = NULL, tol = 1e-6, max_iter = 100,
                            normalizar = c("l2", "inf"), mostrar = FALSE) {
  .matriz(A, real = TRUE)
  .iteraciones(tol, max_iter)
  .mostrar(mostrar)
  normalizar <- match.arg(normalizar)
  if (is.null(x0)) x0 <- rep(1, nrow(A))
  .vector(x0, nrow(A), real = TRUE)
  x <- .normalizar(x0, normalizar)
  for (k in seq_len(max_iter)) {
    y <- as.vector(A %*% x)
    x <- .normalizar(y, normalizar)
    valor <- cociente_rayleigh(A, x)
    error <- max(abs(A %*% x - valor * x))
    .registrar(mostrar, sprintf("Iteracion %d: valor = %.10g, error = %.10g", k, valor, error))
    if (!is.finite(error)) stop("El residuo no es finito.", call. = FALSE)
    if (error < tol) return(list(valor = valor, vector = x, iter = k, error = error))
  }
  if (mostrar) return(list(valor = valor, vector = x, iter = max_iter,
                           error = error, convergencia = FALSE))
  stop("Potencia no alcanzo la tolerancia; revise x0 y los supuestos del metodo.", call. = FALSE)
}

metodo_potencia_inversa <- function(A, x0 = NULL, desplazamiento = 0,
                                    tol = 1e-6, max_iter = 100, mostrar = FALSE) {
  .matriz(A, real = TRUE)
  .iteraciones(tol, max_iter)
  .mostrar(mostrar)
  .escalar(desplazamiento, "desplazamiento")
  if (is.null(x0)) x0 <- rep(1, nrow(A))
  .vector(x0, nrow(A), real = TRUE)
  x <- .normalizar(x0)
  M <- A - desplazamiento * diag(nrow(A))
  if (any(!is.finite(M))) stop("La matriz desplazada no es finita.", call. = FALSE)
  for (k in seq_len(max_iter)) {
    y <- tryCatch(solve(M, x), error = function(e)
      stop("La matriz desplazada es singular o numericamente no invertible.", call. = FALSE))
    x <- .normalizar(y)
    valor <- cociente_rayleigh(A, x)
    error <- max(abs(A %*% x - valor * x))
    .registrar(mostrar, sprintf("Iteracion %d: valor = %.10g, error = %.10g", k, valor, error))
    if (!is.finite(error)) stop("El residuo no es finito.", call. = FALSE)
    if (error < tol) return(list(valor = valor, vector = x, iter = k, error = error))
  }
  if (mostrar) return(list(valor = valor, vector = x, iter = max_iter,
                           error = error, convergencia = FALSE))
  stop("Potencia inversa no alcanzo la tolerancia; revise x0 y el desplazamiento.", call. = FALSE)
}

valores_vectores_propios <- function(A) {
  .matriz(A)
  resultado <- eigen(A)
  list(valores = resultado$values, vectores = resultado$vectors)
}

# Diagonalizacion sobre C. tol controla rango y reconstruccion relativos.
diagonalizar_matriz <- function(A, tol = 1e-8) {
  .matriz(A)
  .tolerancia(tol)
  resultado <- eigen(A)
  P <- resultado$vectors
  singular <- svd(P)$d
  if (min(singular) <= tol * max(singular))
    stop("La matriz no admite una diagonalizacion numericamente fiable con esta tolerancia.", call. = FALSE)
  P_inv <- tryCatch(solve(P), error = function(e)
    stop("No se pudo invertir la matriz de autovectores.", call. = FALSE))
  D <- diag(resultado$values, nrow = nrow(A), ncol = nrow(A))
  error <- max(abs(P %*% D %*% P_inv - A)) / max(1, max(abs(A)))
  if (!is.finite(error) || error >= tol)
    stop("La reconstruccion de la diagonalizacion no cumple la tolerancia.", call. = FALSE)
  list(P = P, D = D, P_inv = P_inv, error = error)
}

# QR y Householder --------------------------------------------------------
# QR base. Si pivotes no es identidad, Q %*% R reconstruye A[, pivotes].
# Se conserva el vector de pivoteo para que la convencion sea explicita.
descomposicion_qr <- function(A) {
  .matriz(A, cuadrada = FALSE, real = TRUE)
  descomp <- qr(A, LAPACK = TRUE)
  Q <- qr.Q(descomp, complete = TRUE)
  R <- qr.R(descomp, complete = TRUE)
  list(Q = Q, R = R, pivote = descomp$pivot)
}

# QR sin desplazamiento para espectro real: puede no converger.
# Solo devuelve diag(Ak) cuando la parte inferior es pequena.
algoritmo_qr <- function(A, tol = 1e-8, max_iter = 1000) {
  .matriz(A, real = TRUE)
  .iteraciones(tol, max_iter)
  Ak <- A
  for (k in seq_len(max_iter)) {
    # En los ejemplos de clase se usa QR sin pivotar para formar RQ.
    descomp <- qr(Ak, LAPACK = FALSE)
    Q <- qr.Q(descomp)
    R <- qr.R(descomp)
    Ak <- R %*% Q
    if (any(!is.finite(Ak))) stop("La iteracion QR produjo valores no finitos.", call. = FALSE)
    error <- max(c(0, abs(Ak[lower.tri(Ak)])))
    if (error < tol) return(list(valores = diag(Ak), iter = k, error = error))
  }
  stop("QR no alcanzo forma triangular real; puede haber estancamiento o autovalores complejos.", call. = FALSE)
}

# v unitario, H = I - 2*v*t(v). El vector cero produce la identidad.
reflector_householder <- function(x) {
  if (!.es_real(x) || !is.null(dim(x)) || length(x) == 0 || any(!is.finite(x)))
    stop("x debe ser un vector real no vacio con valores finitos.", call. = FALSE)
  n <- length(x)
  if (all(x == 0)) return(list(v = numeric(n), H = diag(n)))
  v <- x / max(abs(x))
  signo <- if (v[1] >= 0) 1 else -1
  v[1] <- v[1] + signo * sqrt(sum(v^2))
  v <- v / sqrt(sum(v^2))
  list(v = v, H = diag(n) - 2 * v %*% t(v))
}

# Reduccion simetrica de clase. Devuelve T = t(Q) %*% A %*% Q.
householder_reduction <- function(A, tol = 1e-10) {
  .matriz(A, real = TRUE)
  .tolerancia(tol)
  escala <- max(1, max(abs(A)))
  if (max(abs(A - t(A))) / escala > tol)
    stop("Householder requiere una matriz simetrica.", call. = FALSE)
  n <- nrow(A)
  T <- A
  Q <- diag(n)
  if (n > 2) {
    for (k in seq_len(n - 2)) {
      indices <- (k + 1):n
      ref <- reflector_householder(T[indices, k])
      H <- diag(n)
      H[indices, indices] <- ref$H
      T <- H %*% T %*% H
      Q <- Q %*% H
    }
  }
  if (any(!is.finite(T))) stop("Householder produjo valores no finitos.", call. = FALSE)
  list(T = T, Q = Q)
}

# Auxiliares de estudio ----------------------------------------------------
# Estimacion numerica de multiplicidades: valores proximos dependen de tol.
# Los grupos se forman respecto del primer valor aun no usado de cada grupo.
multiplicidad_espectral <- function(A, tol = 1e-6) {
  .matriz(A)
  .tolerancia(tol)
  valores <- eigen(A, only.values = TRUE)$values
  usados <- rep(FALSE, length(valores))
  salida <- list()
  for (i in seq_along(valores)) {
    if (usados[i]) next
    indices <- which(!usados & Mod(valores - valores[i]) < tol)
    usados[indices] <- TRUE
    lambda <- valores[i]
    M <- A - lambda * diag(nrow(A))
    d <- svd(M)$d
    rango <- sum(d > tol * max(1, max(d)))
    geometrica <- nrow(A) - rango
    salida[[length(salida) + 1]] <- data.frame(
      valor = lambda, algebraica = length(indices), geometrica = geometrica,
      defectivo = geometrica < length(indices))
  }
  do.call(rbind, salida)
}

# Emparejamiento completo por tolerancia; preserva signos y partes imaginarias.
.mismo_espectro <- function(x, y, tol) {
  if (length(x) != length(y)) return(FALSE)
  n <- length(x)
  candidatos <- outer(x, y, function(a, b) Mod(a - b) <= tol * pmax(1, Mod(a), Mod(b)))
  pareja <- integer(n)
  buscar <- function(i) {
    for (j in which(candidatos[i, ] & !vistos)) {
      vistos[j] <<- TRUE
      if (pareja[j] == 0L || buscar(pareja[j])) {
        pareja[j] <<- i
        return(TRUE)
      }
    }
    FALSE
  }
  for (i in seq_len(n)) {
    vistos <- rep(FALSE, n)
    if (!buscar(i)) return(FALSE)
  }
  TRUE
}

# Comprobaciones numericas en ejemplos, no demostraciones de teoremas.
verificar_propiedades_espectrales <- function(A, k = 3, c_escalar = 2, tol = 1e-6) {
  .matriz(A)
  .tolerancia(tol)
  .escalar(k, "k")
  .escalar(c_escalar, "c_escalar")
  if (k < 0 || k != floor(k)) stop("k debe ser un entero no negativo.", call. = FALSE)
  valores <- eigen(A, only.values = TRUE)$values
  cerca <- function(x, y) isTRUE(Mod(x - y) <= tol * max(1, Mod(x), Mod(y)))
  Ak <- diag(nrow(A))
  for (i in seq_len(k)) Ak <- Ak %*% A
  if (any(!is.finite(Ak)) || any(!is.finite(valores^k)))
    stop("La potencia excede la precision numerica disponible.", call. = FALSE)
  inversa <- tryCatch(solve(A), error = function(e) NULL)
  cumple_inversa <- if (is.null(inversa)) NA else
    .mismo_espectro(eigen(inversa, only.values = TRUE)$values, 1 / valores, tol)
  data.frame(
    propiedad = c("traza", "determinante", "transpuesta", "potencia", "desplazamiento", "inversa"),
    cumple = c(cerca(sum(diag(A)), sum(valores)), cerca(det(A), prod(valores)),
      .mismo_espectro(eigen(t(A), only.values = TRUE)$values, valores, tol),
      .mismo_espectro(eigen(Ak, only.values = TRUE)$values, valores^k, tol),
      .mismo_espectro(eigen(A + c_escalar * diag(nrow(A)), only.values = TRUE)$values,
                      valores + c_escalar, tol), cumple_inversa))
}
