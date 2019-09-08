#' Landmark Multi-Dimensional Scalng
#'
#' Landmark Multi-Dimensional Scaling (LMDS) is an extension of classical 'Torgerson' MDS.
#' LMDS scales to significantly larger data sets since it only computes the distances between
#' a set of landmarks and all samples.
#' Has built-in support for sparse matrices.
#'
#' @importFrom assertthat assert_that
#' @importFrom dynutils calculate_distance is_sparse
#'
#' @docType package
#' @name lmds
NULL
