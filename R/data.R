#' Universal part of speech tags, as used by the udpipe and spacy taggers
#'
#' A dataset mapping the tags produced by the POS taggers to
#' either content or function words
#'
#' @format A data frame with 17 rows and 3 variables:
#' \describe{
#'   \item{Tag}{Part of speech tag}
#'   \item{Name}{Full name for the tag}
#'   \item{Type}{"Content" or "Function", or NA (missing) for non-words}
#' }
#' @source \url{https://universaldependencies.org/u/pos/index.html}
"universal_tags"
