% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/visualize.R
\name{visualize}
\alias{visualize}
\title{Visualize dependencies defined by a rule or a list of rules}
\usage{
visualize(x, legend = TRUE)
}
\arguments{
\item{x}{An instance of the S3 \code{rmake.rule} class or a list of such objects}

\item{legend}{Whether to draw a legend}
}
\description{
Visualize dependencies defined by a rule or a list of rules
}
\examples{
job <- c('data1.csv', 'data2.csv') \%>>\%
  rRule('process.R') \%>>\%
  'data.rds' \%>>\%
  markdownRule('report.Rmd') \%>>\%
  'report.pdf'

\dontrun{
visualize(job)
}
}
\seealso{
\code{\link[=makefile]{makefile()}}, \code{\link[=rule]{rule()}}
}
\author{
Michal Burda
}
