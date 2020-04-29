#' Title
#'
#' @param texts Vector of character strings
#' @param parser Tool used to tag parts of speech in the text. One of
#'     "udpipe" or "spacy"
#'
#' @return Table of summary statistics for each text,
#'     with columns
#'
#'     \itemize{
#'         \item \code{n_words} Number of words
#'         \item \code{n_content} Number of content words
#'         \item \code{n_clauses} Number of clauses (estimated using number of verbs)
#'         \item \code{prop_content} Proportion of content words (0.0 to 1.0)
#'         \item \code{prop_function} Proportion of function words (0.0 to 1.0)
#'         \item \code{simple_density} Approximate lexical density, \code{prop_content} * 10
#'         \item \code{lexical_density} Lexical density, \code{prop_content} / \code{n_clauses}
#'     }
#' @export
#'
#' @examples
elf_summary_stats <- function(texts, parser = "udpipe") {
    parser <- match.arg(parser, c("udpipe", "spacy"))

    pos_tags <- switch(
        parser,
        udpipe = get_pos_tags(texts),
        spacy = get_spacy_tags(texts)
    )

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
