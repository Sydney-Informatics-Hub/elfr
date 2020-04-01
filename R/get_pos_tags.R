#' Get part of speech tags
#'
#' @param texts vector of character strings
#'
#' @return
#' @export
#'
#' @examples
get_pos_tags <- function(texts) {
    tagger <- load_tagger()
    annotated <- udpipe::udpipe_annotate(tagger, texts)

    annotated <- annotated %>%
        tibble::as_tibble() %>%
        dplyr::mutate(pos_type = get_pos_type(upos))

    annotated
}
