% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/deriveHMM.R
\name{deriveHMM}
\alias{deriveHMM}
\title{Derive a standard hidden Markov model from a set of sequences.}
\usage{
deriveHMM(
  x,
  seqweights = NULL,
  residues = NULL,
  states = NULL,
  modelend = FALSE,
  pseudocounts = "background",
  logspace = TRUE
)
}
\arguments{
\item{x}{a list of named character vectors representing emissions
from the model. The 'names' attribute should represent the hidden state
from which each residue was emitted. "DNAbin" and "AAbin" list
objects are also supported for modeling DNA or amino acid sequences.}

\item{seqweights}{either NULL (all sequences are given
weights of 1) or a numeric vector the same length as \code{x} representing
the sequence weights used to derive the model.}

\item{residues}{either NULL (default; emitted residues are automatically
detected from the sequences), a case sensitive character vector
specifying the residue alphabet, or one of the character strings
"RNA", "DNA", "AA", "AMINO". Note that the default option can be slow for
large lists of character vectors. Furthermore, the default setting
\code{residues = NULL} will not detect rare residues that are not present
in the sequences, and thus will not assign them emission probabilities
in the model. Specifying the residue alphabet is therefore
recommended unless x is a "DNAbin" or "AAbin" object.}

\item{states}{either NULL (default; the unique Markov states are
automatically detected from the 'names' attributes of the input
sequences), or a case sensitive character vector specifying the unique
Markov states (or a superset of the unique states) to appear in the
model. The latter option is recommended since it saves computation time
and ensures that all valid Markov states appear in the model,
regardless of their possible absence from the training dataset.}

\item{modelend}{logical indicating whether transition probabilites
to the end state of the standard hidden Markov model should be
modeled (if applicable). Defaults to FALSE.}

\item{pseudocounts}{character string, either "background", Laplace"
or "none". Used to account for the possible absence of certain
transition and/or emission types in the input sequences.
If \code{pseudocounts = "background"} (default), pseudocounts
are calculated from the background transition and emission
frequencies in the training dataset.
If \code{pseudocounts = "Laplace"} one of each possible transition
and emission type is added to the training dataset (default).
If \code{pseudocounts = "none"} no pseudocounts are added (not
usually recommended, since low frequency transition/emission types
may be excluded from the model).
Alternatively this argument can be a two-element list containing
a matrix of transition pseudocounts
as its first element and a matrix of emission pseudocounts as its
second. If this option is selected, both matrices must have row and column
names corresponding with the residues (column names of emission matrix)
and states (row and column names of the transition matrix and
row names of the emission matrix). For downstream applications
the first row and column of the transition matrix should be named
"Begin".}

\item{logspace}{logical indicating whether the emission and transition
probabilities in the returned model should be logged. Defaults to TRUE.}
}
\value{
an object of class \code{"HMM"}.
}
\description{
\code{deriveHMM} calculates the maximum likelihood hidden Markov model from
  a list of training sequences, each a vector of residues named according
  the state from which they were emitted.
}
\details{
This function creates a standard hidden Markov model (object class:
  \code{"HMM"}) using the method described in Durbin et al (1998) chapter
  3.3. It assumes the state sequence is known
  (as opposed to the \code{\link{train.HMM}} function, which is used
  when the state sequence is unknown) and provided as the names attribute(s)
  of the input sequences. The output object is a simple list with elements
  "A" (transition probability matrix) and "E" (emission probability matrix),
  and the "class" attribute "HMM". The emission matrix has the same number
  of rows as the number of states, and the same number of columns as the
  number of unique symbols that can be emitted (i.e. the residue alphabet).
  The number of rows and columns in the transition probability matrix
  should be one more the number of states, to include the silent "Begin"
  state in the first row and column. Despite its name, this state is
  also used when modeling transitions to the (silent)
  end state, which are entered in the first column.
}
\examples{
 data(casino)
 deriveHMM(list(casino))
}
\references{
Durbin R, Eddy SR, Krogh A, Mitchison G (1998) Biological
  sequence analysis: probabilistic models of proteins and nucleic acids.
  Cambridge University Press, Cambridge, United Kingdom.
}
\seealso{
\code{\link{derivePHMM}}
}
\author{
Shaun Wilkinson
}
