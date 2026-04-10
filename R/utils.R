unwrap_extendr_result <- function(x) {
  if (inherits(x, "extendr_result")) {
    if (!is.null(x$err)) {
      stop(x$err, call. = FALSE)
    }
    return(x$ok)
  }

  x
}
