# Funciones internas --------------------------------------------------------
.es_real <- function(x) is.numeric(x) && !is.complex(x)

.escalar <- function(x, nombre) {
  if (!.es_real(x) || length(x) != 1L || !is.finite(x))
    stop(paste(nombre, "debe ser un numero real finito."), call. = FALSE)
}

.tolerancia <- function(tol, nombre = "tol") {
  .escalar(tol, nombre)
  if (tol <= 0) stop(paste(nombre, "debe ser mayor que cero."), call. = FALSE)
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

.sin_convergencia <- function(metodo, mostrar = FALSE) {
  mensaje <- paste(metodo, "no alcanzo la tolerancia en max_iter iteraciones.")
  if (!mostrar) stop(mensaje, call. = FALSE)
  warning(paste(mensaje, "Se devuelve la ultima aproximacion."), call. = FALSE)
}

.vector_texto <- function(x) paste0("(", paste(format(x, digits = 6), collapse = ", "), ")")

.limpiar <- function(x) {
  x <- zapsmall(x, digits = 12)
  if (is.complex(x) && all(Im(x) == 0)) x <- Re(x)
  x
}

.intervalo <- function(f, a, b, tol, max_iter) {
  if (!is.function(f)) stop("f debe ser una funcion.", call. = FALSE)
  .escalar(a, "a")
  .escalar(b, "b")
  .iteraciones(tol, max_iter)
  if (a >= b) stop("El intervalo debe cumplir a < b.", call. = FALSE)
  fa <- .evaluar(f, a)
  fb <- .evaluar(f, b)
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

.fila_potencia <- function(k, y, x, valor, error) {
  names(y) <- paste0("y", seq_along(y))
  names(x) <- paste0("x", seq_along(x))
  data.frame(c(list(iter = k), as.list(y), as.list(x), list(valor = valor, error = error)))
}

.registrar_potencia <- function(mostrar, k, y, x, valor, error) {
  .registrar(mostrar, sprintf("Iteracion %d: y = %s, x = %s, valor = %.10g, error = %.10g",
                              k, .vector_texto(y), .vector_texto(x), valor, error))
}

.escalar_columnas <- function(V, escala) {
  if (escala == "l2") return(V)
  for (j in seq_len(ncol(V))) {
    modulos <- Mod(V[, j])
    i <- if (escala == "pivote") which(modulos > 1e-12 * max(modulos))[1] else which.max(modulos)
    V[, j] <- V[, j] / V[i, j]
  }
  .limpiar(V)
}

.escalonada <- function(M, tol = 1e-10) {
  fila <- 1
  for (j in seq_len(ncol(M))) {
    if (fila > nrow(M)) break
    p <- fila - 1 + which.max(Mod(M[fila:nrow(M), j]))
    if (Mod(M[p, j]) <= tol) next
    M[c(fila, p), ] <- M[c(p, fila), ]
    M[fila, ] <- M[fila, ] / M[fila, j]
    for (i in seq_len(nrow(M))[-fila]) M[i, ] <- M[i, ] - M[i, j] * M[fila, ]
    fila <- fila + 1
  }
  M
}

.texto_polinomio <- function(coeficientes) {
  n <- length(coeficientes) - 1
  texto <- ""
  for (i in seq_along(coeficientes)) {
    a <- coeficientes[i]
    if (a == 0) next
    p <- n - i + 1
    potencia <- if (p == 0) "" else if (p == 1) "lambda" else paste0("lambda^", p)
    if (is.complex(a)) {
      signo <- " + "
      valor <- paste0("(", format(a, digits = 7), ")")
    } else {
      signo <- if (a < 0) " - " else " + "
      valor <- if (abs(a) == 1 && p > 0) "" else format(abs(a), digits = 7)
    }
    if (nzchar(valor) && p > 0) valor <- paste0(valor, "*")
    texto <- paste0(texto, signo, valor, potencia)
  }
  sub("^ \\+ ", "", sub("^ - ", "-", texto))
}

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

# Raices ------------------------------------------------------------------
regula_falsi <- function(f, a, b, tol = 1e-6, max_iter = 100, mostrar = FALSE) {
  .mostrar(mostrar)
  extremos <- .intervalo(f, a, b, tol, max_iter)
  fa <- extremos[1]
  fb <- extremos[2]
  historial <- data.frame(iter = integer(), a = numeric(), b = numeric(),
                          c = numeric(), f_c = numeric(), error = numeric())
  for (k in seq_len(max_iter)) {
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
                                 convergencia = TRUE, historial = historial))
    if (c <= a || c >= b)
      stop("Regula Falsi se estanco por precision numerica.", call. = FALSE)
    if (sign(fa) != sign(fc)) {
      .registrar(mostrar, "Se actualiza b <- c")
      b <- c
      fb <- fc
    } else {
      .registrar(mostrar, "Se actualiza a <- c")
      a <- c
      fa <- fc
    }
  }
  .sin_convergencia("Regula Falsi", mostrar)
  list(raiz = c, iter = max_iter, error = error, convergencia = FALSE, historial = historial)
}

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
                  convergencia = TRUE, historial = historial))
    if (c <= a || c >= b)
      stop("Biseccion se estanco por precision numerica.", call. = FALSE)
    if (sign(fa) != sign(fc)) {
      .registrar(mostrar, "Se actualiza b <- c")
      b <- c
    } else {
      .registrar(mostrar, "Se actualiza a <- c")
      a <- c
      fa <- fc
    }
  }
  .sin_convergencia("Biseccion", mostrar)
  list(raiz = c, iter = max_iter, error = error, residuo = abs(fc),
       convergencia = FALSE, historial = historial)
}

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
                                 convergencia = TRUE, historial = historial))
    x0 <- x1
  }
  .sin_convergencia("Punto fijo", mostrar)
  list(raiz = x0, iter = max_iter, error = error, convergencia = FALSE, historial = historial)
}

# Valores y vectores propios ----------------------------------------------
valores_vectores_propios <- function(A, escala = c("l2", "pivote", "max")) {
  .matriz(A)
  escala <- match.arg(escala)
  resultado <- eigen(A)
  list(valores = resultado$values, vectores = .escalar_columnas(resultado$vectors, escala))
}

polinomio_caracteristico <- function(A) {
  .matriz(A)
  n <- nrow(A)
  coeficientes <- c(1, numeric(n))
  M <- matrix(0, n, n)
  for (k in seq_len(n)) {
    M <- A %*% M + coeficientes[k] * diag(n)
    coeficientes[k + 1] <- -sum(diag(A %*% M)) / k
  }
  if (.es_real(A) && all(A == round(A)) && max(abs(coeficientes)) < 2^52)
    coeficientes <- round(coeficientes)
  raices <- polyroot(rev(coeficientes))
  reales <- abs(Im(raices)) <= 1e-10 * pmax(1, Mod(raices))
  raices[reales] <- Re(raices[reales])
  raices <- .limpiar(raices[order(-Mod(raices))])
  list(coeficientes = coeficientes, polinomio = .texto_polinomio(coeficientes), raices = raices)
}

espacio_propio <- function(A, lambda, tol = 1e-8, escala = c("pivote", "max", "l2")) {
  .matriz(A)
  if (!(is.numeric(lambda) || is.complex(lambda)) || length(lambda) != 1L || !is.finite(lambda))
    stop("lambda debe ser un numero real o complejo finito.", call. = FALSE)
  .tolerancia(tol)
  escala <- match.arg(escala)
  n <- nrow(A)
  descomp <- svd(A - lambda * diag(n), nu = 0, nv = n)
  rango <- sum(descomp$d > tol * max(1, descomp$d))
  if (rango == n)
    stop("lambda no es valor propio de A con esta tolerancia.", call. = FALSE)
  base <- descomp$v[, (rango + 1):n, drop = FALSE]
  base <- if (escala == "pivote") t(.escalonada(t(base))) else .escalar_columnas(base, escala)
  list(base = .limpiar(base), dimension = n - rango)
}

multiplicidad_espectral <- function(A, tol = 1e-6, tol_valores = 1e-6) {
  .matriz(A)
  .tolerancia(tol)
  .tolerancia(tol_valores, "tol_valores")
  n <- nrow(A)
  valores <- eigen(A, only.values = TRUE)$values
  grupo <- seq_len(n)
  for (i in seq_len(n)) for (j in seq_len(n)) {
    if (Mod(valores[i] - valores[j]) <= tol_valores * max(1, Mod(valores[i]), Mod(valores[j])))
      grupo[grupo == grupo[j]] <- grupo[i]
  }
  salida <- list()
  for (g in unique(grupo)) {
    algebraica <- sum(grupo == g)
    lambda <- mean(valores[grupo == g])
    if (is.complex(lambda) && abs(Im(lambda)) <= tol_valores * max(1, Mod(lambda)))
      lambda <- Re(lambda)
    d <- svd(A - lambda * diag(n))$d
    geometrica <- n - sum(d > tol * max(1, max(d)))
    salida[[length(salida) + 1]] <- data.frame(
      valor = lambda, algebraica = algebraica, geometrica = geometrica,
      defectivo = geometrica < algebraica)
  }
  do.call(rbind, salida)
}

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

# Metodos de potencia ------------------------------------------------------
cociente_rayleigh <- function(A, x) {
  .matriz(A)
  .vector(x, nrow(A))
  x <- .normalizar(x)
  valor <- sum(Conj(x) * as.vector(A %*% x)) / sum(Mod(x)^2)
  if (!is.finite(valor)) stop("El cociente de Rayleigh no es finito.", call. = FALSE)
  valor
}

metodo_potencia <- function(A, x0 = NULL, tol = 1e-6, max_iter = 100,
                            normalizar = c("l2", "inf"), mostrar = FALSE) {
  .matriz(A, real = TRUE)
  .iteraciones(tol, max_iter)
  .mostrar(mostrar)
  normalizar <- match.arg(normalizar)
  if (is.null(x0)) x0 <- rep(1, nrow(A))
  .vector(x0, nrow(A), real = TRUE)
  x <- .normalizar(x0, normalizar)
  historial <- NULL
  for (k in seq_len(max_iter)) {
    y <- as.vector(A %*% x)
    x <- .normalizar(y, normalizar)
    valor <- cociente_rayleigh(A, x)
    error <- max(abs(A %*% x - valor * x))
    if (!is.finite(error)) stop("El residuo no es finito.", call. = FALSE)
    historial <- rbind(historial, .fila_potencia(k, y, x, valor, error))
    .registrar_potencia(mostrar, k, y, x, valor, error)
    if (error < tol) return(list(valor = valor, vector = x, iter = k, error = error,
                                 convergencia = TRUE, historial = historial))
  }
  .sin_convergencia("Potencia", mostrar)
  list(valor = valor, vector = x, iter = max_iter, error = error,
       convergencia = FALSE, historial = historial)
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
  historial <- NULL
  for (k in seq_len(max_iter)) {
    y <- tryCatch(as.vector(solve(M, x)), error = function(e)
      stop("La matriz desplazada es singular o numericamente no invertible.", call. = FALSE))
    x <- .normalizar(y)
    valor <- cociente_rayleigh(A, x)
    error <- max(abs(A %*% x - valor * x))
    if (!is.finite(error)) stop("El residuo no es finito.", call. = FALSE)
    historial <- rbind(historial, .fila_potencia(k, y, x, valor, error))
    .registrar_potencia(mostrar, k, y, x, valor, error)
    if (error < tol) return(list(valor = valor, vector = x, iter = k, error = error,
                                 convergencia = TRUE, historial = historial))
  }
  .sin_convergencia("Potencia inversa", mostrar)
  list(valor = valor, vector = x, iter = max_iter, error = error,
       convergencia = FALSE, historial = historial)
}

# QR y Householder --------------------------------------------------------
reflector_householder <- function(x, signo = c("+", "-")) {
  if (!.es_real(x) || !is.null(dim(x)) || length(x) == 0 || any(!is.finite(x)))
    stop("x debe ser un vector real no vacio con valores finitos.", call. = FALSE)
  signo <- match.arg(signo)
  n <- length(x)
  if (all(x == 0)) return(list(v = numeric(n), H = diag(n)))
  v <- x / max(abs(x))
  s <- if (v[1] >= 0) 1 else -1
  norma <- sqrt(sum(v^2))
  if (signo == "+") {
    v[1] <- v[1] + s * norma
  } else {
    v[1] <- -s * sum(v[-1]^2) / (abs(v[1]) + norma)
  }
  if (all(v == 0)) return(list(v = numeric(n), H = diag(n)))
  v <- v / sqrt(sum(v^2))
  list(v = v, H = diag(n) - 2 * v %*% t(v))
}

householder_qr <- function(A, signo = c("-", "+"), mostrar = FALSE) {
  .matriz(A, cuadrada = FALSE, real = TRUE)
  signo <- match.arg(signo)
  .mostrar(mostrar)
  m <- nrow(A)
  escala <- max(1, max(abs(A)))
  R <- A
  Q <- diag(m)
  pasos <- list()
  for (k in seq_len(min(m - 1, ncol(A)))) {
    indices <- k:m
    x <- R[indices, k]
    x[abs(x) < 1e-14 * escala] <- 0
    ref <- reflector_householder(x, signo)
    H <- diag(m)
    H[indices, indices] <- ref$H
    R <- H %*% R
    R[(k + 1):m, k] <- 0
    Q <- Q %*% H
    pasos[[k]] <- list(v = ref$v, H = H, A = R)
    if (mostrar) {
      cat(sprintf("Paso %d: v = %s\nH%d =\n", k, .vector_texto(ref$v), k))
      print(zapsmall(H))
      cat(sprintf("A(%d) = H%d A(%d) =\n", k, k, k - 1))
      print(zapsmall(R))
    }
  }
  if (any(!is.finite(R))) stop("Householder produjo valores no finitos.", call. = FALSE)
  list(Q = Q, R = R, pasos = pasos)
}

descomposicion_qr <- function(A, signo = c("-", "+")) {
  resultado <- householder_qr(A, signo = match.arg(signo))
  list(Q = resultado$Q, R = resultado$R, pivote = seq_len(ncol(A)))
}

householder_reduction <- function(A, tol = 1e-10, signo = c("+", "-")) {
  .matriz(A, real = TRUE)
  .tolerancia(tol)
  signo <- match.arg(signo)
  escala <- max(1, max(abs(A)))
  simetrica <- max(abs(A - t(A))) / escala <= tol
  n <- nrow(A)
  T <- A
  Q <- diag(n)
  if (n > 2) {
    for (k in seq_len(n - 2)) {
      indices <- (k + 1):n
      x <- T[indices, k]
      x[abs(x) < 1e-14 * escala] <- 0
      ref <- reflector_householder(x, signo)
      H <- diag(n)
      H[indices, indices] <- ref$H
      T <- H %*% T %*% H
      T[(k + 2):n, k] <- 0
      if (simetrica) T[k, (k + 2):n] <- 0
      Q <- Q %*% H
    }
  }
  if (any(!is.finite(T))) stop("Householder produjo valores no finitos.", call. = FALSE)
  list(T = T, Q = Q, forma = if (simetrica) "tridiagonal" else "Hessenberg")
}

algoritmo_qr <- function(A, tol = 1e-8, max_iter = 1000) {
  .matriz(A, real = TRUE)
  .iteraciones(tol, max_iter)
  Ak <- A
  for (k in seq_len(max_iter)) {
    descomp <- householder_qr(Ak)
    Q <- descomp$Q
    R <- descomp$R
    Ak <- R %*% Q
    if (any(!is.finite(Ak))) stop("La iteracion QR produjo valores no finitos.", call. = FALSE)
    error <- max(c(0, abs(Ak[lower.tri(Ak)])))
    if (error < tol) return(list(valores = diag(Ak), iter = k, error = error,
                                 convergencia = TRUE, matriz = Ak))
  }
  .sin_convergencia("Algoritmo QR", FALSE)
  list(valores = diag(Ak), iter = max_iter, error = error, convergencia = FALSE, matriz = Ak)
}

