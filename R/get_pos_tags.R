#' Get part of speech tags
#'
#' @param texts vector of character strings
#'
#' @return Dataframe with tags for each word in the texts
#' @export
#'
#' @examples
#' get_pos_tags(c("The quick brown fox jumped swiftly over the lazy dog.",
#'                "She told him that she loved him."))
get_pos_tags <- function(texts) {
    tagger <- load_tagger()
    annotated <- udpipe::udpipe_annotate(tagger, texts)

    annotated <- annotated %>%
        tibble::as_tibble() %>%
        dplyr::mutate(pos_type = get_pos_type(upos))

    annotated
}
