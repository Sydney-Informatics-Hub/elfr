#' Get part of speech tags using the udpipe tagger
#'
#' @param texts vector of character strings
#'
#' @return tibble with tags for each word in the texts
get_udpipe_tags <- function(texts) {
    tagger <- load_tagger()
    annotated <- udpipe::udpipe_annotate(tagger, texts)

    as_tibble(annotated)
}
