# lmds 0.1.0

Initial release

* Landmark Multi-Dimensional Scaling (LMDS) is an extension of classical Torgerson MDS.
  LMDS aims to produce the same dimensionality reduction as `cmdscale()`, but scale
  linearly with respect to the number of samples.
  
Resubmission:
* I extended the description field in the DESCRIPTION to better reflect the purpose of
  the package. I did not add a reference, as there is no corresponding manuscript. 
  
* I added `\value{}` fields to each of the functions.

# Test environments

* local Fedora 30 installation, R 3.6.0
* ubuntu 16.04.5 LTS (on travis-ci), R 3.6.0
* win-builder (devel and release)

# R CMD check results
── R CMD check results ───────────────────────────────────────── lmds 0.1.0 ────
Duration: 35.9s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

R CMD check succeeded
