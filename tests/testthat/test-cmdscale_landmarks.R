context("Testing cmdscale_landmarks()")

x <- as.matrix(iris[,1:4])
lms <- select_landmarks(x, distance_method = "euclidean", landmark_method = "sample", num_landmarks = 500)

test_that("Reducing dimensionality", {
  dimred <- cmdscale_landmarks(lms, ndim = 10)

  expect_is(dimred, "matrix")
  expect_equal(dim(dimred), c(nrow(x), 10))

  dist1 <- as.matrix(dist(x))
  dist2 <- as.matrix(dist(dimred))

  expect_gte(cor(as.vector(dist1), as.vector(dist2)), .5)
})

test_that("Reducing dimensionality", {
  dimred <- cmdscale_landmarks(lms, ndim = 3)

  expect_is(dimred, "matrix")
  expect_equal(dim(dimred), c(nrow(x), 3))

  dist1 <- as.matrix(dist(x))
  dist2 <- as.matrix(dist(dimred))

  expect_gte(cor(as.vector(dist1), as.vector(dist2)), .5)
})
