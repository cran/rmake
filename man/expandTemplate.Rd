% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expandTemplate.R
\name{expandTemplate}
\alias{expandTemplate}
\title{Expand template rules into a list of rules by replacing \code{rmake} variables with their values}
\usage{
expandTemplate(template, vars)
}
\arguments{
\item{template}{An instance of the S3 \code{rmake.rule} class or a list of such objects.}

\item{vars}{A named character vector, matrix, or data frame with variable definitions.
For character vector, names are variable names, values are variable values. For matrix or
data frame, colnames are variable names and column values are variable values.}
}
\value{
A list of rules created from \code{template} by replacing \code{rmake} variables.
}
\description{
Take a template job (i.e., a list of template rules), or a template rule, and create a job (or rule)
from them by replacing \code{rmake} variables in the template with their values. The \code{rmake} variable
is a identified by the \code{$[VARIABLE_NAME]} string anywhere in the definition of a rule.
}
\details{
If \code{vars} is a character vector then all variables in \code{vars} are replaced in \code{template} so that
the result will contain \code{length(template)} rules. If \code{vars} is a data frame or a character
matrix then the replacement of variables is performed row-wisely. That is, a new sequence of rules is
created from \code{template} for each row of variables in \code{vars} so that the result will contain
\code{nrow(vars) * length(template)} rules.
}
\examples{
tmpl <- rRule('data-$[VERSION].csv', 'process-$[TYPE].R', 'output-$[VERSION]-$[TYPE].csv')

job <- expandTemplate(tmpl, c(VERSION='small', TYPE='a'))
# is equivalent to
job <- list(rRule('data-small.csv', 'process-a.R', 'output-small-a.csv'))

job <- expandTemplate(tmpl, expand.grid(VERSION=c('small', 'big'), TYPE=c('a', 'b', 'c')))
# is equivalent to
job <- list(rRule('data-small.csv', 'process-a.R', 'output-small-a.csv'),
            rRule('data-big.csv', 'process-a.R', 'output-big-a.csv'),
            rRule('data-small.csv', 'process-b.R', 'output-small-b.csv'),
            rRule('data-big.csv', 'process-b.R', 'output-big-b.csv'),
            rRule('data-small.csv', 'process-c.R', 'output-small-c.csv'),
            rRule('data-big.csv', 'process-c.R', 'output-big-c.csv'))
}
\seealso{
\code{\link[=replaceVariables]{replaceVariables()}}, \code{\link[=rule]{rule()}}
}
\author{
Michal Burda
}
