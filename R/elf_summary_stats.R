#' Get Evaluative Linguistic Framework statistics for texts
#'
#' @importFrom rlang .data
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
#'         \item \code{n_clauses} Number of clauses (estimated using number of non-auxiliary verbs).
#'            Part-of-speech tagging is imperfect, and may not identify verbs in all cases, so
#'            we assume a minimum of 1 clause per sentence even when no verbs are identified.
#'         \item \code{prop_content} Proportion of content words (0.0 to 1.0)
#'         \item \code{prop_function} Proportion of function words (0.0 to 1.0)
#'         \item \code{simple_density} Approximate lexical density, \code{prop_content} * 10
#'         \item \code{lexical_density} Lexical density, \code{prop_content} / \code{n_clauses}
#'     }
#' @export
#'
#' @examples
#' elf_summary_stats(c("The quick brown fox jumped swiftly over the lazy dog.",
#'                     "She told him that she loved him."))
elf_summary_stats <- function(texts, parser = "udpipe") {
    parser <- match.arg(parser, c("udpipe", "spacy"))

    pos_tags <- get_pos_tags(texts, parser = parser) %>%
        # NOTE: the parsers assign each text an id like "text123" - because
        #   these are character the numbers may not sort in order,
        #   so make sure they are correctly ordered before grouping/summarising
        dplyr::mutate(doc_id = forcats::fct_inorder(.data$doc_id))

    # Count clauses (number of non-auxiliary verbs)
    clause_counts <- pos_tags %>%
        dplyr::group_by(.data$doc_id, .data$sentence_id) %>%
        # Assume at least one clause per sentence
        dplyr::summarise(sentence_clauses = max(1, sum(.data$upos == "VERB"))) %>%
        dplyr::group_by(.data$doc_id) %>%
        dplyr::summarise(n_clauses = sum(.data$sentence_clauses))

    pos_tags %>%
        dplyr::left_join(clause_counts, by = "doc_id") %>%
        dplyr::group_by(.data$doc_id) %>%
        dplyr::summarise(
            # Number of words for the purpose of counting lexical density,
            #   i.e. any word that we can tag as content/function
            n_words = sum(! is.na(.data$pos_type)),
            n_content = sum(.data$pos_type == "Content", na.rm = TRUE),
            n_function = sum(.data$pos_type == "Function", na.rm = TRUE),
            n_clauses = dplyr::first(.data$n_clauses),
            prop_content = .data$n_content / .data$n_words,
            prop_function = .data$n_function / .data$n_words,
            # Multiply by 10 to approximate lexical density
            simple_density = .data$prop_content * 10,
            lexical_density = .data$n_content / .data$n_clauses
        ) %>%
        # Make sure we ungroup
        dplyr::ungroup() %>%
        # Include the original text
        dplyr::mutate(text = texts) %>%
        dplyr::select(.data$text, dplyr::everything(), - .data$doc_id)
}
