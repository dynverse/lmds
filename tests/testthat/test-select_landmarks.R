context("Testing select_landmarks()")

x <- as.matrix(iris[,1:4])
test_that("Selecting landmarks", {
  lms <- select_landmarks(x, distance_method = "euclidean", landmark_method = "sample", num_landmarks = 500)

  expect_is(lms, "matrix")
  expect_gte(min(lms), 0)
  expect_equal(dim(lms), c(150, nrow(x)))

  lix <- attr(lms, "landmark_ix")
  expect_false(is.null(lix))
  expect_true(all(lix >= 1 & lix <= nrow(x)))

  expect_equivalent(
    lms[cbind(seq_along(lix), lix)],
    rep(0, length(lix)),
    tolerance = 1e-4
  )

  dis <- as.matrix(dist(x))[lix, , drop = FALSE]
  expect_equal(as.vector(dis), as.vector(lms), tolerance = 1e-4)
})

test_that("Selecting landmarks with different parameters", {
  lms <- select_landmarks(x, distance_method = "pearson", landmark_method = "sample", num_landmarks = 101)

  expect_is(lms, "matrix")
  expect_gte(min(lms), 0)
  expect_equal(dim(lms), c(101, nrow(x)))

  lix <- attr(lms, "landmark_ix")
  expect_false(is.null(lix))

  expect_true(all(lix >= 1 & lix <= nrow(x)))

  expect_equivalent(
    lms[cbind(seq_along(lix), lix)],
    rep(0, length(lix)),
    tolerance = 1e-4
  )

  dis <- (1 - (cor(t(x)) + 1) / 2)[lix, , drop = FALSE]
  expect_equal(as.vector(dis), as.vector(lms), tolerance = 1e-4)
})
