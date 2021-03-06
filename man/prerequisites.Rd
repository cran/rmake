% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getters.R
\name{prerequisites}
\alias{prerequisites}
\alias{getters}
\alias{targets}
\alias{tasks}
\alias{terminals}
\title{Return given set of properties of all rules in a list}
\usage{
prerequisites(x)

targets(x)

tasks(x)

terminals(x)
}
\arguments{
\item{x}{An instance of the \code{rmake.rule} class or a list of such instances}
}
\value{
A character vector of unique values of the selected property obtained from all rules in \code{x}
}
\description{
\code{targets()} returns a character vector of all unique values of \code{target} properties,
\code{prerequisites()} returns \code{depends} and \code{script} properties,
and \code{tasks()} returns \code{task} properties of the given \code{\link[=rule]{rule()}} or list of rules.
}
\details{
\code{terminals()} returns only such targets that are not prerequisites to any other rule.
}
\examples{
job <- 'data.csv' \%>>\%
  rRule('process.R', task='basic') \%>>\%
  'data.rds' \%>>\%
  markdownRule('report.Rnw', task='basic') \%>>\%
  'report.pdf'

prerequisites(job)    # returns c('process.R', data.csv', 'report.Rnw', 'data.rds')
targets(job)          # returns c('data.rds', 'report.pdf')
tasks(job)            # returns 'basic'
}
\seealso{
\code{\link[=rule]{rule()}}
}
\author{
Michal Burda
}
