## ----tt-setup, include = FALSE------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 5
)
library(rmake)

## ----task_ex, eval=FALSE------------------------------------------------------
# make('all')
# make('preview')

## ----task_assign, eval=FALSE--------------------------------------------------
# library(rmake)
# job <- c(
#   "data.csv" %>>% rRule("preprocess.R") %>>% "data.rds",
#   "data.rds" %>>% markdownRule("preview.Rmd", task = "preview") %>>%
#     "preview.pdf",
#   "data.rds" %>>% markdownRule("final.Rmd", task = "final") %>>%
#     "final.pdf"
# )
# makefile(job, "Makefile")

## ----params_ex, eval=FALSE----------------------------------------------------
# library(rmake)
# job <- c(
#   "data.csv" %>>% rRule("fit.R", params = list(alpha = 0.1)) %>>% "out-0.1.rds",
#   "data.csv" %>>% rRule("fit.R", params = list(alpha = 0.2)) %>>% "out-0.2.rds",
#   "data.csv" %>>% rRule("fit.R", params = list(alpha = 0.3)) %>>% "out-0.3.rds"
# )
# makefile(job, "Makefile")

## ----params_script, eval=FALSE------------------------------------------------
# # fit.R
# str(params)
# # List of 5
# #  $ .target : chr "out-0.1.rds"
# #  $ .script : chr "fit.R"
# #  $ .depends: chr "data.csv"
# #  $ .task   : chr "all"
# #  $ alpha   : num 0.1

## ----getparam_ex, eval=FALSE--------------------------------------------------
# # fit.R
# library(rmake)
# 
# dataName <- getParam(".depends")
# resultName <- getParam(".target")
# alpha <- getParam("alpha")
# 
# # Use parameters...
# cat("Processing with alpha =", alpha, "\n")

## ----getparam_default, eval=FALSE---------------------------------------------
# dataName <- getParam(".depends", "data.csv")
# resultName <- getParam(".target", "result.rds")
# alpha <- getParam("alpha", 0.2)

## ----template_simple, eval=FALSE----------------------------------------------
# tmpl <- "data-$[NUM].csv" %>>%
#   rRule("process.R") %>>%
#   "result-$[NUM].csv"
# variants <- data.frame(NUM = 1:99)
# job <- expandTemplate(tmpl, variants)

## ----template_multi-----------------------------------------------------------
variants <- expand.grid(DATA = c("dataSimple", "dataComplex"),
                        TYPE = c("lm", "rf", "nnet"))
print(variants)

tmpl <- "$[DATA].csv" %>>% 
  rRule("fit-$[TYPE].R") %>>%
  "result-$[DATA]_$[TYPE].csv"
job <- expandTemplate(tmpl, variants)
print(job)

## ----template_dup-------------------------------------------------------------
tmpl <- "data.csv" %>>%
  rRule("pre.R") %>>% "pre.rds" %>>%
  rRule("comp.R", params = list(alpha = "$[NUM]")) %>>% 
  "result-$[NUM].csv"
variants <- data.frame(NUM = 1:5)
job <- expandTemplate(tmpl, variants)
print(job)

## ----template_error, error=TRUE-----------------------------------------------
try({
tmpl <- "data-$[TYPE].csv" %>>% 
  markdownRule("report.Rmd") %>>% "report.pdf"
variants <- data.frame(TYPE = c("a", "b", "c"))
job <- expandTemplate(tmpl, variants)
print(job)

# This would error:
# makefile(job)
# Error: Multiple rules detected for the same target
})

## ----combined_ex, eval=FALSE--------------------------------------------------
# # Create template for different models
# tmpl <- "data.csv" %>>%
#   rRule("fit-$[MODEL].R", params = list(model = "$[MODEL]")) %>>%
#   "model-$[MODEL].rds"
# 
# # Expand for different models
# variants <- data.frame(MODEL = c("linear", "rf", "xgboost"))
# training_job <- expandTemplate(tmpl, variants)
# 
# # Add evaluation tasks
# eval_job <- c(
#   c("model-linear.rds", "model-rf.rds", "model-xgboost.rds") %>>%
#     rRule("evaluate.R") %>>% "evaluation.rds",
#   "evaluation.rds" %>>%
#     markdownRule("report.Rmd", task = "report") %>>% "report.pdf"
# )
# 
# # Combine all rules
# job <- c(training_job, eval_job)
# makefile(job, "Makefile")

