lmds
================

[![Build
Status](https://travis-ci.org/dynverse/lmds.svg?branch=master)](https://travis-ci.org/dynverse/lmds)

# `lmds`: Landmark Multi-Dimensional Scaling

Landmark Multi-Dimensional Scaling (LMDS) is an extension of classical
‘Torgerson’ MDS. LMDS scales to significantly larger data sets since
it only computes the distances between a set of landmarks and all
samples. `lmds` built-in support for sparse matrices.

In essence, LMDS attempts to produce the same dimensionality reduction
as `cmdscale()`, but in a much more scaleable manner.

``` r
library(lmds)
x <- as.matrix(iris[,1:4])
dimred <- lmds(
  x,
  ndim = 2, 
  distance_method = "euclidean", 
  landmark_method = "sample",
  num_landmarks = 20
)
qplot(dimred[,1], dimred[,2]) + labs(title = "lmds()") + theme_classic()
```

<img src="man/figures/compare-1.png" width="100%" />

``` r

dimred <- cmdscale(dist(x))
qplot(dimred[,1], dimred[,2]) + labs(title = "cmdscale()") + theme_classic()
```

<img src="man/figures/compare-2.png" width="100%" />

The execution time of `lmds()` scales linearly with respect to the
dataset size. <img src="man/figures/timings-1.png" width="100%" />

## Latest changes

Check out `news(package = "lmds")` or [NEWS.md](NEWS.md) for a full list
of
changes.

<!-- This section gets automatically generated from inst/NEWS.md, and also generates inst/NEWS -->

### Recent changes in lmds 0.1.0

Initial release of lmds. \* Landmark Multi-Dimensional Scaling (LMDS) is
an extension of classical ‘Torgerson’ MDS. LMDS scales to significantly
larger data sets since it only computes the distances between a set of
landmarks and all samples. Has built-in support for sparse matrices.
