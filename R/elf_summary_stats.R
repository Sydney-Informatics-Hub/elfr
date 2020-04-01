#' Title
#'
#' @param texts Vector of character strings
#'
#' @return
#' @export
#'
#' @examples
elf_summary_stats <- function(texts) {
    pos_tags <- get_pos_tags(texts)

    pos_tags %>%
        dplyr::group_by(doc_id) %>%
        dplyr::summarise(
            # Number of words for the purpose of counting lexical density,
            #   i.e. any word that we can tag as content/function
            n_words = sum(! is.na(pos_type)),
            n_content = sum(pos_type == "Content", na.rm = TRUE),
            n_function = sum(pos_type == "Function", na.rm = TRUE),
            n_clauses = sum(upos == "VERB"),
            prop_content = n_content / n_words,
            prop_function = n_function / n_words,
            # Multiply by 10 to approximate lexical density
            simple_density = prop_content * 10,
            lexical_density = n_content / n_clauses
        ) %>%
        # Make sure we ungroup
        dplyr::ungroup() %>%
        dplyr::mutate(text = texts) %>%
        dplyr::select(text, everything(), - doc_id)
}
