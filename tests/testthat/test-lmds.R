context("Testing lmds()")

set.seed(1)
x <- as.matrix(iris[,1:4])

test_that("Perform dimred", {
  out1 <- lmds(x)

  expect_is(out1, "matrix")
  expect_identical(rownames(out1), rownames(x))
  expect_identical(colnames(out1), paste0("comp_", seq_len(ncol(out1))))

  set.seed(1)
  out2 <- lmds(x, ndim = 2)
  expect_is(out2, "matrix")
  expect_identical(rownames(out2), rownames(x))
  expect_identical(colnames(out2), paste0("comp_", seq_len(ncol(out2))))
  expect_equal(ncol(out2), 2)

  v1 <- as.vector(as.matrix(dist(out1)))
  v2 <- as.vector(as.matrix(dist(out2)))

  expect_true(all(cor(cbind(v1, v2)) > .25))
})

largex <- Matrix::rsparsematrix(10000, 1000, .05)

test_that("P^erform dimred on large matrix", {
  out1 <- lmds(largex)
  expect_is(out1, "matrix")
  expect_identical(rownames(out1), rownames(largex))
  expect_identical(colnames(out1), paste0("comp_", seq_len(ncol(out1))))
})
