## ----echo=FALSE---------------------------------------------------------------
  library(knitr)
  options(prompt='R> ')
  options(continue='+  ')
  opts_chunk$set(prompt=TRUE, echo=TRUE, comment=NA)

## ----eval=FALSE---------------------------------------------------------------
# install.packages("rmake")

## ----eval=FALSE---------------------------------------------------------------
# install.packages("devtools")
# devtools::install_github("beerda/rmake")

## -----------------------------------------------------------------------------
Sys.getenv("R_HOME")
Sys.getenv("R_ARCH")

## -----------------------------------------------------------------------------
library(rmake)

## ----eval=FALSE---------------------------------------------------------------
# rmakeSkeleton(".")

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# library(rmake)
# job <- list()
# makefile(job, "Makefile")

## ----eval=FALSE---------------------------------------------------------------
# make()

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# d <- read.csv("data.csv")
# sums <- data.frame(ID="sum",
#                    V1=sum(d$V1),
#                    V2=sum(d$V2))
# write.csv(sums, "sums.csv", row.names=FALSE)

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# library(rmake)
# job <- list(rRule(target="sums.csv", script="script.R", depends="data.csv"))
# makefile(job, "makefile")

## ----eval=FALSE---------------------------------------------------------------
# make()

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# library(rmake)
# job <- list(
#   rRule(target="sums.csv", script="script.R", depends="data.csv"),
#   markdownRule(target="analysis.pdf", script="analysis.Rmd",
#                depends="sums.csv")
# )
# makefile(job, "makefile")

## ----eval=FALSE---------------------------------------------------------------
# make()

## -----------------------------------------------------------------------------
job <- "data.csv" %>>% rRule("script.R") %>>%
  "sums.csv" %>>% markdownRule("analysis.Rmd") %>>%
  "analysis.pdf"

## ----eval=FALSE---------------------------------------------------------------
# job <- c('in1.csv', 'in2.csv') %>>%
#   rRule('run.R') %>>%
#   c('out1.csv', 'out2.csv')

## -----------------------------------------------------------------------------
chain1 <- "data1.csv" %>>% rRule("preprocess1.R") %>>% "intermed1.rds"
chain2 <- "data2.csv" %>>% rRule("preprocess2.R") %>>% "intermed2.rds"
chain3 <- c("intermed1.rds", "intermed2.rds") %>>% rRule("merge.R") %>>%
  "merged.rds" %>>% markdownRule("report.Rmd") %>>% "report.pdf"

job <- c(chain1, chain2, chain3)

## ----eval=FALSE---------------------------------------------------------------
# make("clean")

## ----eval=FALSE---------------------------------------------------------------
# make("-j8")

## -----------------------------------------------------------------------------
print(job)

## ----eval=FALSE---------------------------------------------------------------
# visualize(job, legend=FALSE)

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# rRule(target, script, depends = NULL, params = list(), task = "all")

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# markdownRule(target, script, depends = NULL, format = "all",
#              params = list(), task = "all")

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# offlineRule(target, message, depends = NULL, task = "all")

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# rule(target, depends = NULL, build = NULL, clean = NULL,
#      task = "all", phony = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# r <- rule(target="test.json", depends="test.js", build="node test.js",
#      clean="$(RM) test.json")

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# defaultVars["JS"] <- "/usr/bin/node"

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# library(rmake)
# defaultVars["JS"] <- "/usr/bin/node"
# job <- list(rule(target="test.json",
#                  depends="test.js",
#                  build="$(JS) test.js",
#                  clean="$(RM) test.json"))
# makefile(job, "Makefile")

## -----------------------------------------------------------------------------
inShell({ result <- 1+1; saveRDS(result, "result.rds") })

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# rule(target="result.rds",
#      build=inShell({ result <- 1+1; saveRDS(result, "result.rds") }),
#      clean="$(RM) result.rds")

## ----eval=FALSE---------------------------------------------------------------
# make('all')

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# library(rmake)
# job <- c(
#   "data.csv" %>>% rRule("preprocess.R") %>>% "data.rds",
#   "data.rds" %>>% markdownRule("preview.Rmd", task="preview") %>>%
#       "preview.pdf",
#   "data.rds" %>>% markdownRule("final.Rmd", task="final") %>>% "final.pdf"
# )
# makefile(job, "Makefile")

## ----eval=FALSE---------------------------------------------------------------
# make("preview")

## ----eval=FALSE---------------------------------------------------------------
# make("final")

## ----eval=FALSE---------------------------------------------------------------
# make("all")

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# library(rmake)
# job <- c(
#   "data.csv" %>>% rRule("fit.R", params=list(alpha=0.1)) %>>% "out-0.1.rds",
#   "data.csv" %>>% rRule("fit.R", params=list(alpha=0.2)) %>>% "out-0.2.rds",
#   "data.csv" %>>% rRule("fit.R", params=list(alpha=0.3)) %>>% "out-0.3.rds",
#   "data.csv" %>>% rRule("fit.R", params=list(alpha=0.4)) %>>% "out-0.4.rds"
# )
# makefile(job, "Makefile")

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# # the fit.R file
# str(params)

## ----eval=FALSE---------------------------------------------------------------
# make("all")

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# # the fit.R file
# library(rmake)
# 
# dataName <- getParam(".depends")
# resultName <- getParam(".target")
# alpha <- getParam("alpha")
# 
# # now we can use these variables to do here some real work...
# 
# cat("dataName:", dataName, "\n")
# cat("resultName:", resultName, "\n")
# cat("alpha:", alpha, "\n")

## ----eval=FALSE---------------------------------------------------------------
# source("fit.R")

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# dataName <- getParam(".depends", "data.csv")
# resultName <- getParam(".target", "result.rds")
# alpha <- getParam("alpha", 0.2)

## ----eval=FALSE---------------------------------------------------------------
# source("fit.R")

## ----eval=FALSE---------------------------------------------------------------
# job <- c(
#   "data-1.csv" %>>% rRule("process.R") %>>% "result-1.csv",
#   "data-2.csv" %>>% rRule("process.R") %>>% "result-2.csv",
#   # ...
#   "data-99.csv" %>>% rRule("process.R") %>>% "result-99.csv"
# )

## ----eval=FALSE---------------------------------------------------------------
# tmpl <- "data-$[NUM].csv" %>>% rRule("process.R") %>>% "result-$[NUM].csv"
# variants <- data.frame(NUM=1:99)
# job <- expandTemplate(tmpl, variants)

## -----------------------------------------------------------------------------
variants <- expand.grid(DATA=c("dataSimple", "dataComplex"),
                        TYPE=c("lm", "rf", "nnet"))
print(variants)
tmpl <- "$[DATA].csv" %>>% rRule("fit-$[TYPE].R") %>>%
  "result-$[DATA]_$[TYPE].csv"
job <- expandTemplate(tmpl, variants)

## -----------------------------------------------------------------------------
print(job)

## -----------------------------------------------------------------------------
tmpl <- "data.csv" %>>%
  rRule("pre.R") %>>%  "pre.rds" %>>%
  rRule("comp.R", params=list(alpha="$[NUM]")) %>>% "result-$[NUM].csv"
variants <- data.frame(NUM=1:5)
job <- expandTemplate(tmpl, variants)

## ----eval=FALSE,prompt=FALSE--------------------------------------------------
# "data.csv" %>>% rRule("pre.R") %>>%  "pre.rds"

## -----------------------------------------------------------------------------
print(job)

## -----------------------------------------------------------------------------
tmpl <- "data-$[TYPE].csv" %>>% markdownRule("report.Rmd") %>>%
    "report.pdf"
variants <- data.frame(TYPE=c("a", "b", "c"))
job <- expandTemplate(tmpl, variants)
print(job)

## ----error=TRUE---------------------------------------------------------------
try({
makefile(job)
})

