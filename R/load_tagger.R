load_tagger <- function() {
    model_path <- system.file("extdata", "english-ewt-ud-2.4-190531.udpipe",
                              package="elfer")
    tagger <- udpipe::udpipe_load_model(model_path)
    tagger
}
