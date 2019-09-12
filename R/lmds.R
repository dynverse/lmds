#' Landmark MDS
#'
#' A fast dimensionality reduction method scaleable to large numbers of samples.
#' Landmark Multi-Dimensional Scaling (LMDS) is an extension of classical 'Torgerson MDS',
#' but rather than calculating a complete distance matrix between all pairs of samples,
#' only the distances between a set of landmarks and the samples are calculated.
#'
#' @inheritParams select_landmarks
#' @inheritParams cmdscale_landmarks
#'
#' @export
#'
#' @include cmdscale_landmarks.R select_landmarks.R
#'
#' @return The dimensionality reduction in the form of a `nrow(x)` by `ndim` matrix.
#'
#' @examples
#' library(Matrix)
#' x <- Matrix::rsparsematrix(1000, 1000, .01)
#' lmds(x, ndim = 3)
lmds <- dynutils::inherit_default_params(
  list(select_landmarks, cmdscale_landmarks),
  function(
    x,
    ndim,
    distance_method,
    landmark_method,
    num_landmarks
  ) {
    # select the landmarks
    dist_2lm <- select_landmarks(
      x = x,
      distance_method = distance_method,
      landmark_method = landmark_method,
      num_landmarks = num_landmarks
    )

    # reduce dimensionality for landmarks and project to non-landmarks
    dimred <- cmdscale_landmarks(
      dist_2lm = dist_2lm,
      ndim = ndim,
      rescale = TRUE
    )

    rownames(dimred) <- rownames(x)


    dimred
  }
)
