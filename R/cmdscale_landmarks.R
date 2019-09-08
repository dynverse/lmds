#' Perform MDS on landmarks and project other samples to the same space
#'
#' @param dist_2lm Distance matrix between the landmarks and all the samples in original dataset
#' @param ndim The number of dimensions
#' @param rescale Whether or not to rescale the final dimensionality reduction (recommended)
#' @param ... Extra params to pass to [irlba::irlba()]
#'
#' @importFrom irlba partial_eigen
#' @importFrom dynutils scale_uniform
#'
#' @export
#'
#' @examples
#' library(Matrix)
#' x <- Matrix::rsparsematrix(10000, 1000, .01)
#' dist_2lm <- select_landmarks(x)
#' cmdscale_landmarks(dist_2lm)
cmdscale_landmarks <- function(dist_2lm, ndim = 3, rescale = TRUE, ...) {
  assert_that(
    !is.null(attr(dist_2lm, "landmark_ix")) || (!is.null(rownames(dist_2lm)) && !is.null(colnames(dist_2lm))),
    is.numeric(ndim), length(ndim) == 1, ndim >= 1,
    is.logical(rescale), length(rescale) == 1, !is.na(rescale)
  )

  ix_lm <- attr(dist_2lm, "landmark_ix")
  if (is.null(ix_lm)) {
    ix_lm <- match(rownames(dist_2lm), colnames(dist_2lm))
  }

  # short hand notations
  x <- dist_2lm[, ix_lm, drop = FALSE]^2
  n <- as.integer(nrow(x))
  N <- as.integer(ncol(dist_2lm))

  # double center data
  mu_n <- rowMeans(x)
  mu <- mean(x)
  x_dc <-
    sweep(
      sweep(x, 1, mu_n, "-"),
      2, mu_n, "-"
    ) + mu

  # classical MDS on landmarks
  e <- irlba::partial_eigen(-x_dc / 2, symmetric = TRUE, n = ndim, ...)
  ev <- e$values
  evec <- e$vectors
  ndim1 <- sum(ev > 0)
  if (ndim1 < ndim) {
    warning(gettextf("only %d of the first %d eigenvalues are > 0", ndim1, ndim), domain = NA)
    evec <- evec[, ev > 0, drop = FALSE]
    ev <- ev[ev > 0]
    ndim <- ndim1
  }

  # distance-based triangulation
  points_inv <- evec / rep(sqrt(ev), each = n)
  dimred <- (-t(dist_2lm - rep(mu_n, each = N)) / 2) %*% points_inv

  if (rescale) {
    dimred <- dynutils::scale_uniform(dimred)
  }

  dimred
}
