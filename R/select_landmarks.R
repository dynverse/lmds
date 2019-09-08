#' Select landmarks from dataset
#'
#' In addition, the distances between the landmarks and all samples are calculated.
#'
#' @param x A matrix, optionally sparse.
#' @param distance_method The distance metric to use. Options are "euclidean" (default), "pearson", "spearman", "cosine", "manhattan".
#' @param landmark_method The landmark selection method to use. Options are "sample" (default).
#' @param num_landmarks The number of landmarks to use,
#'
#' @return The distance matrix between the landmarks and all samples. In addition, an attribute `"landmark_ix"`
#'   denotes the indices of landmarks that were sampled.
#'
#' @export
#'
#' @examples
#' library(Matrix)
#' x <- Matrix::rsparsematrix(1000, 1000, .01)
#' select_landmarks(x)
select_landmarks <- function(
  x,
  distance_method = c("euclidean", "pearson", "spearman", "cosine", "manhattan"),
  landmark_method = c("sample"),
  num_landmarks = 500
) {
  distance_method <- match.arg(distance_method)
  landmark_method <- match.arg(landmark_method)
  assert_that(
    is.matrix(x) || is_sparse(x),
    is.numeric(num_landmarks), length(num_landmarks) == 1, num_landmarks > 2
  )

  # parameter check on num_landmarks
  if (num_landmarks > nrow(x)) {
    num_landmarks <- nrow(x)
  }

  # naive -> just subsample the cell ids
  if (landmark_method == "sample") {
    ix_lm <- sample.int(nrow(x), num_landmarks)
    dist_2lm <- as.matrix(calculate_distance(x[ix_lm, , drop = FALSE], x, method = distance_method))
  }

  dist_2lm <- zapsmall(dist_2lm)

  attr(dist_2lm, "landmark_ix") <- ix_lm

  dist_2lm
}
