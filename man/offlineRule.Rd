% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/offlineRule.R
\name{offlineRule}
\alias{offlineRule}
\title{Rule for requesting manual user action}
\usage{
offlineRule(target, message, depends = NULL, task = "all")
}
\arguments{
\item{target}{A character vector of target file names of the manual (offline) build
command}

\item{message}{An error message to be issued if targets are older than dependencies
from \code{depends}}

\item{depends}{A character vector of file names the targets depend on}

\item{task}{A character vector of parent task names. The mechanism of tasks allows to
group rules. Anything different from \code{'all'} will
cause creation of a new task depending on the given rule. Executing \code{make taskname}
will then force building of this rule.}
}
\value{
Instance of S3 class \code{rmake.rule}
}
\description{
Instead of building the target, this rule simply issues the given error message.
This rule is useful for cases, where the target \code{target} depends on \code{depends}, but
has to be updated by some manual process. So if \code{target} is older than any of its
dependencies, \code{make} will throw an error until the user manually updates the target.
}
\examples{
r <- offlineRule(target='offlinedata.csv',
                 message='Please re-generate manually offlinedata.csv',
                 depends=c('source1.csv', 'source2.csv'))

# generate the content of a makefile (as character vector)
makefile(list(r))

# generate to file
tmp <- tempdir()
makefile(list(r), file.path(tmp, "Makefile"))
}
\seealso{
\code{\link[=rule]{rule()}}, \code{\link[=makefile]{makefile()}}
}
\author{
Michal Burda
}
