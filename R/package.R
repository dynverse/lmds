#' Landmark Multi-Dimensional Scalng
#'
#' A fast dimensionality reduction method scaleable to large numbers of samples.
#' Landmark Multi-Dimensional Scaling (LMDS) is an extension of classical Torgerson MDS´,
#' but rather than calculating a complete distance matrix between all pairs of samples,
#' only the distances between a set of landmarks and the samples are calculated.
#'
#' @importFrom assertthat assert_that
#' @importFrom dynutils calculate_distance is_sparse
#'
#' @docType package
#' @name lmds
NULL
