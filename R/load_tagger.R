#' Load the udpipe English model
#'
#' @return A udpipe model, ready to be used in \code{\link[udpipe]{udpipe_annotate}}.
load_tagger <- function() {
    model_path <- system.file("extdata", "english-ewt-ud-2.4-190531.udpipe",
                              package="elfr")
    tagger <- udpipe::udpipe_load_model(model_path)
    tagger
}
