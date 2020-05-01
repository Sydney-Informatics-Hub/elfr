#' Get part of speech tags using spacy
#'
#' @importFrom rlang .data
#'
#' @param texts vector of character strings
#'
#' @return tibble with tags for each word/token in the texts
get_spacy_tags <- function(texts) {
    annotated <- spacyr::spacy_parse(texts, pos = TRUE, tag = TRUE, dependency = TRUE,
                                     entity = FALSE)

    annotated <- annotated %>%
        tibble::as_tibble() %>%
        # Rename for consistency with udpipe output
        dplyr::rename(upos = .data$pos)

    annotated
}
