% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/iterators.R
\name{itoken}
\alias{itoken}
\alias{itoken.character}
\alias{itoken.list}
\alias{itoken.iterator}
\alias{itoken_parallel}
\alias{itoken_parallel.character}
\alias{itoken_parallel.iterator}
\alias{itoken_parallel.list}
\title{Iterators (and parallel iterators) over input objects}
\usage{
itoken(iterable, ...)

\method{itoken}{character}(iterable, preprocessor = identity,
  tokenizer = space_tokenizer, n_chunks = 10,
  progressbar = interactive(), ids = NULL, ...)

\method{itoken}{list}(iterable, n_chunks = 10,
  progressbar = interactive(), ids = names(iterable), ...)

\method{itoken}{iterator}(iterable, preprocessor = identity,
  tokenizer = space_tokenizer, progressbar = interactive(), ...)

itoken_parallel(iterable, ...)

\method{itoken_parallel}{character}(iterable, preprocessor = identity,
  tokenizer = space_tokenizer, n_chunks = 10, ids = NULL, ...)

\method{itoken_parallel}{iterator}(iterable, preprocessor = identity,
  tokenizer = space_tokenizer, n_chunks = 1L, ...)

\method{itoken_parallel}{list}(iterable, n_chunks = 10, ids = NULL,
  ...)
}
\arguments{
\item{iterable}{an object from which to generate an iterator}

\item{...}{arguments passed to other methods}

\item{preprocessor}{\code{function} which takes chunk of
\code{character} vectors and does all pre-processing.
Usually \code{preprocessor} should return a
\code{character} vector of preprocessed/cleaned documents. See "Details"
section.}

\item{tokenizer}{\code{function} which takes a \code{character} vector from
\code{preprocessor}, split it into tokens and returns a \code{list}
of \code{character} vectors. If you need to perform stemming -
call stemmer inside tokenizer. See examples section.}

\item{n_chunks}{\code{integer}, the number of pieces that object should
be divided into. Then each chunk is processed independently (and in case \code{itoken_parallel}
\bold{in parallel if some parallel backend is registered}).
Usually there is tradeoff: larger number of chunks means lower memory footprint, but slower (if
\code{preprocessor, tokenizer} functions are efficiently vectorized). And small number
of chunks means larger memory footprint but faster execution (again if user
supplied \code{preprocessor, tokenizer} functions are efficiently vectorized).}

\item{progressbar}{\code{logical} indicates whether to show progress bar.}

\item{ids}{\code{vector} of document ids. If \code{ids} is not provided,
\code{names(iterable)} will be used. If \code{names(iterable) == NULL},
incremental ids will be assigned.}
}
\description{
This family of function creates iterators over input objects
in order to create vocabularies, or DTM and TCM matrices.
iterators usually used in following functions : \link{create_vocabulary},
\link{create_dtm}, \link{vectorizers},
\link{create_tcm}. See them for details.
}
\details{
S3 methods for creating an itoken iterator from list of tokens
  \itemize{
  \item{\code{list}: all elements of the input list should be
    character vectors containing tokens}
  \item{\code{character}: raw text
  source: the user must provide a tokenizer function}
  \item{\code{ifiles}: from files, a user must provide a function to read in the file
    (to \link{ifiles}) and a function to tokenize it (to \link{itoken})}
  \item{\code{idir}: from a directory, the user must provide a function to
    read in the files (to \link{idir}) and a function to tokenize it (to \link{itoken})}
  \item{\code{ifiles_parallel}: from files in parallel}
  }
}
\examples{
data("movie_review")
txt = movie_review$review[1:100]
ids = movie_review$id[1:100]
it = itoken(txt, tolower, word_tokenizer, n_chunks = 10)
it = itoken(txt, tolower, word_tokenizer, n_chunks = 10, ids = ids)
# Example of stemming tokenizer
# stem_tokenizer =function(x) {
#   lapply(word_tokenizer(x), SnowballC::wordStem, language="en")
# }
it = itoken_parallel(movie_review$review[1:100], n_chunks = 4)
system.time(dtm <- create_dtm(it, hash_vectorizer(2**16), type = 'TsparseMatrix'))
}
\seealso{
\link{ifiles}, \link{idir}, \link{create_vocabulary},
  \link{create_dtm}, \link{vectorizers},
  \link{create_tcm}
}
