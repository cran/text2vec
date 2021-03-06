% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/distance.R
\name{similarities}
\alias{similarities}
\alias{sim2}
\alias{psim2}
\title{Pairwise Similarity Matrix Computation}
\usage{
sim2(x, y = NULL, method = c("cosine", "jaccard"), norm = c("l2",
  "none"))

psim2(x, y, method = c("cosine", "jaccard"), norm = c("l2", "none"))
}
\arguments{
\item{x}{first matrix.}

\item{y}{second matrix. For \code{sim2} \code{y = NULL} set by default.
This means that we will assume \code{y = x} and calculate similarities between all rows of the \code{x}.}

\item{method}{\code{character}, the similarity measure to be used. One of \code{c("cosine", "jaccard")}.}

\item{norm}{\code{character = c("l2", "none")} - how to scale input matrices. If they already scaled - use \code{"none"}}
}
\value{
\code{sim2} returns \code{matrix} of similarities between each row of
matrix \code{x} and each row of matrix \code{y}.

\code{psim2} returns \code{vector} of "parallel" similarities between rows of \code{x} and \code{y}.
}
\description{
\code{sim2} calculates pairwise similarities between the
rows of two data matrices. \bold{Note} that some methods work only on sparse matrices and
others work only on dense matrices.

\code{psim2} calculates "parallel" similarities between the rows of two data matrices.
}
\details{
Computes the similarity matrix using given method.

\code{psim2} takes two matrices and return a single vector.
giving the ‘parallel’ similarities of the vectors.
}
