# elfr: implementing the Evaluative Linguistic Framework for Questionnaires in R

`elfr` is an R package that implements some of the calculations from
the Evaluative Linguistic Framework for Questionnaires (ELF-Q).

This page has a quick guide to installing and using the package,
you can find more documentation at <https://sydney-informatics-hub.github.io/elfr/>

## Installation

`elfr` is set up as an R package. To install `elfr`, first install the
`remotes` package by running:

```r
install.packages("remotes")
```

in your R console

Then you should be able to install the `elfr` package using:

```r
remotes::install_github("Sydney-Informatics-Hub/elfr", build_vignettes = TRUE)
```

## Loading and using the library

Once the library has been installed successfully, you should be
able to load the library into your session and use the
`elf_summary_stats()` function:

```r
library(elfr)
elf_summary_stats("The quick brown fox jumped over the lazy dog")
```

See the "Basic usage" vignette for more information:

```r
vignette("basic_usage", package = 'elfr')
```

The functions should also have help pages available via `?elf_summary_stats`.

### Note on the spacy parser

By default `elfr` uses the `udpipe` tagger, which should work without additional
setup, but there is also the option to use the `spacy` tagger. Using
the spacy taggers requires setting up a Python environment and downloading
the relevant language models. To set this up, use:

```r
spacyr::spacy_install()
spacyr::spacy_download_langmodel(model = "en")
```

This might be tougher to set up on Windows: see the help page
at `?spacyr::spacy_install`.
