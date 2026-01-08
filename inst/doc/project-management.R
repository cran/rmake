## ----pm-setup, include = FALSE------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 5
)
library(rmake)

## ----pm-skeleton, eval=FALSE--------------------------------------------------
# library(rmake)
# rmakeSkeleton(".")

## ----skeleton_code, eval=FALSE------------------------------------------------
# library(rmake)
# job <- list()
# makefile(job, "Makefile")

## ----make_run, eval=FALSE-----------------------------------------------------
# make()

## ----clean, eval=FALSE--------------------------------------------------------
# make("clean")

## ----parallel, eval=FALSE-----------------------------------------------------
# make("-j8")  # Run up to 8 tasks simultaneously

