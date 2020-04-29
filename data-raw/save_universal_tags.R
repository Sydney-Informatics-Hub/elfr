universal_tags <- readxl::read_excel("universal_tags.xlsx", na = c("", "NA"))
usethis::use_data(universal_tags, overwrite = TRUE)
