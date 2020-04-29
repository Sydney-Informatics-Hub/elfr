#' Get part of speech tags using spacy
#'
#' @param texts vector of character strings
#'
#' @return Dataframe with tags for each word/token in the texts
#' @export
#'
#' @examples
#' get_spacy_tags(c("The quick brown fox jumped swiftly over the lazy dog.",
#'                  "She told him that she loved him."))
get_spacy_tags <- function(texts) {
    annotated <- spacyr::spacy_parse(texts, pos = TRUE, tag = TRUE, dependency = TRUE,
                                     entity = FALSE)

    annotated <- annotated %>%
        tibble::as_tibble() %>%
        # Rename for consistency with udpipe output
        dplyr::rename(upos = pos) %>%
        dplyr::mutate(pos_type = get_pos_type(upos))

    annotated
}
