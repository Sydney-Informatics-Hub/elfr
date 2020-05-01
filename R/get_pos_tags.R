#' Get part of speech tags
#' @importFrom rlang .data
#'
#' @param texts vector of character strings
#' @param parser One of \code{"udpipe"} or \code{"spacy"}. The udpipe tagger is
#'   used by default
#'
#' @return Dataframe with tags for each word in the texts
#' @export
#'
#' @examples
#' get_pos_tags(c("The quick brown fox jumped swiftly over the lazy dog.",
#'                "She told him that she loved him."))
get_pos_tags <- function(texts, parser = "udpipe") {
    parser <- match.arg(parser, c("udpipe", "spacy"))

    pos_tags <- switch(
        parser,
        udpipe = get_udpipe_tags(texts),
        spacy = get_spacy_tags(texts)
    )

    pos_tags <- pos_tags %>%
        dplyr::mutate(pos_type = get_pos_type(.data$upos))

    pos_tags
}
