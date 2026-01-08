## ----gs-setup, include = FALSE------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 5
)
library(rmake)

## ----gs-install, eval=FALSE---------------------------------------------------
# install.packages("rmake")

## ----install_github, eval=FALSE-----------------------------------------------
# install.packages("devtools")
# devtools::install_github("beerda/rmake")

## ----load---------------------------------------------------------------------
library(rmake)

## ----check_env, eval=FALSE----------------------------------------------------
# R.home()

## ----check_env_vars, eval=FALSE-----------------------------------------------
# Sys.getenv("R_HOME")

## ----gs-skeleton, eval=FALSE--------------------------------------------------
# library(rmake)
# rmakeSkeleton(".")

## ----skeleton_content, eval=FALSE---------------------------------------------
# library(rmake)
# job <- list()
# makefile(job, "Makefile")

## ----script_content, eval=FALSE-----------------------------------------------
# d <- read.csv("data.csv")
# sums <- data.frame(ID = "sum",
#                    V1 = sum(d$V1),
#                    V2 = sum(d$V2))
# write.csv(sums, "sums.csv", row.names = FALSE)

## ----define_rule, eval=FALSE--------------------------------------------------
# library(rmake)
# job <- list(rRule(target = "sums.csv",
#                   script = "script.R",
#                   depends = "data.csv"))
# makefile(job, "Makefile")

## ----run_make, eval=FALSE-----------------------------------------------------
# make()

## ----pipe_example, eval=FALSE-------------------------------------------------
# library(rmake)
# job <- "data.csv" %>>%
#   rRule("script.R") %>>%
#   "sums.csv"
# makefile(job, "Makefile")

## ----add_markdown, eval=FALSE-------------------------------------------------
# library(rmake)
# job <- list(
#   rRule(target = "sums.csv", script = "script.R", depends = "data.csv"),
#   markdownRule(target = "analysis.pdf", script = "analysis.Rmd",
#                depends = "sums.csv")
# )
# makefile(job, "Makefile")

## ----pipe_chain, eval=FALSE---------------------------------------------------
# library(rmake)
# job <- "data.csv" %>>%
#   rRule("script.R") %>>%
#   "sums.csv" %>>%
#   markdownRule("analysis.Rmd") %>>%
#   "analysis.pdf"
# makefile(job, "Makefile")

## ----run_make2, eval=FALSE----------------------------------------------------
# make()

## ----make_options, eval=FALSE-------------------------------------------------
# # Run all tasks
# make()
# 
# # Run specific task
# make("all")
# 
# # Clean generated files
# make("clean")
# 
# # Parallel execution (8 jobs)
# make("-j8")

## ----gs-visualize, eval=FALSE-------------------------------------------------
# visualize(job, legend = FALSE)

## ----multiple_deps------------------------------------------------------------
chain1 <- "data1.csv" %>>% rRule("preprocess1.R") %>>% "intermed1.rds"
chain2 <- "data2.csv" %>>% rRule("preprocess2.R") %>>% "intermed2.rds"
chain3 <- c("intermed1.rds", "intermed2.rds") %>>% 
  rRule("merge.R") %>>% "merged.rds" %>>% 
  markdownRule("report.Rmd") %>>% "report.pdf"

job <- c(chain1, chain2, chain3)

## ----multiple_deps_alt, eval=FALSE--------------------------------------------
# job <- c(
#   "data1.csv" %>>% rRule("preprocess1.R") %>>% "intermed1.rds",
#   "data2.csv" %>>% rRule("preprocess2.R") %>>% "intermed2.rds",
#   c("intermed1.rds", "intermed2.rds") %>>%
#     rRule("merge.R") %>>% "merged.rds" %>>%
#     markdownRule("report.Rmd") %>>% "report.pdf"
# )

