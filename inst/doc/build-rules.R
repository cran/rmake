## ----br-setup, include = FALSE------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 5
)
library(rmake)

## ----rrule_sig, eval=FALSE----------------------------------------------------
# rRule(target, script, depends = NULL, params = list(), task = "all")

## ----rrule_ex, eval=FALSE-----------------------------------------------------
# rRule(target = "output.rds",
#       script = "process.R",
#       depends = "input.csv")

## ----markdown_sig, eval=FALSE-------------------------------------------------
# markdownRule(target, script, depends = NULL, format = "all",
#              params = list(), task = "all")

## ----markdown_ex, eval=FALSE--------------------------------------------------
# markdownRule(target = "report.pdf",
#              script = "report.Rmd",
#              depends = "data.rds",
#              format = "pdf_document")

## ----knitr_sig, eval=FALSE----------------------------------------------------
# knitrRule(target, script, depends = NULL, params = list(), task = "all")

## ----knitr_ex, eval=FALSE-----------------------------------------------------
# knitrRule(target = "report.tex",
#           script = "report.Rnw",
#           depends = c("data1.csv", "data2.csv"))

## ----copy_sig, eval=FALSE-----------------------------------------------------
# copyRule(target, depends, task = "all")

## ----copy_ex, eval=FALSE------------------------------------------------------
# copyRule(target = "backup/data.csv",
#          depends = "data.csv")

## ----dep_sig, eval=FALSE------------------------------------------------------
# depRule(target, depends = NULL, task = "all")

## ----dep_ex, eval=FALSE-------------------------------------------------------
# # Ensure all preprocessing is done before starting the analysis
# depRule(target = "analysis-ready",
#         depends = c("data1.rds", "data2.rds", "data3.rds"))

## ----subdir_sig, eval=FALSE---------------------------------------------------
# subdirRule(target, depends = NULL, task = "all", targetTask = "all")

## ----subdir_ex, eval=FALSE----------------------------------------------------
# subdirRule(target = "subproject",
#            targetTask = "all")

## ----offline_sig, eval=FALSE--------------------------------------------------
# offlineRule(target, message, depends = NULL, task = "all")

## ----offline_ex, eval=FALSE---------------------------------------------------
# offlineRule(target = "cleaned_data.csv",
#             message = "Please manually clean data.csv and save as cleaned_data.csv",
#             depends = "data.csv")

## ----rule_sig, eval=FALSE-----------------------------------------------------
# rule(target, depends = NULL, build = NULL, clean = NULL,
#      task = "all", phony = FALSE)

## ----rule_custom_ex, eval=FALSE-----------------------------------------------
# r <- rule(target = "test.json",
#           depends = "test.js",
#           build = "node test.js",
#           clean = "$(RM) test.json")

## ----vars_ex, eval=FALSE------------------------------------------------------
# defaultVars["JS"] <- "/usr/bin/node"
# 
# job <- list(rule(target = "test.json",
#                  depends = "test.js",
#                  build = "$(JS) test.js",
#                  clean = "$(RM) test.json"))

## ----inshell_ex---------------------------------------------------------------
inShell({ result <- 1 + 1; saveRDS(result, "result.rds") })

## ----inshell_rule, eval=FALSE-------------------------------------------------
# rule(target = "result.rds",
#      build = inShell({ result <- 1 + 1; saveRDS(result, "result.rds") }),
#      clean = "$(RM) result.rds")

