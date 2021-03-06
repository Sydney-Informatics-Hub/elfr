#' Identify content vs. function words
#'
#' @param tag Vector of part of speech tags
#'
#' @return Character vector containing "Content", "Function", or NA
get_pos_type <- function(tag) {
    pos_type <- elfr::universal_tags$Type[match(tag, elfr::universal_tags$Tag)]
    pos_type
}
