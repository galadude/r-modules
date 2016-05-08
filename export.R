# 08/05-16

import(utils)
import(methods)
import(aoos)

export("setFolder", "exprt", "mexprt")

# 0. private variables

.folder <- "."
.exn <- "csv"

# 1. internal functions

.versionNumber <- function(fn) {
  re <- paste(fn, ".*\\.", .exn)
  fs <- grepl(re, list.files(path = .folder))
  sum(fs) + 1
}

.pathName <- function(fn, version = FALSE) {

    if (version) {
        ver <- paste0(" (ver. ", .versionNumber(fn), ")")
    } else {
        ver <- ""
    }

    today     <- format(Sys.Date(), format = "%y-%d-%m ")
    file.name <- paste0(today, fn, ver, ".", .exn)
    file.path(.folder, file.name)
}

# 2. interface

exprt(x) %g% {
    stop("only works for lists and data.frames")
}

exprt(x ~ list) %m% {
    Map(.exprt.backbone, x, names(x))
}

exprt(x ~ data.frame) %m% {
    name <- deparse(substitute(x))
    .exprt.backbone(x, name)
}

.exprt.backbone <- function(tb, name) {
    write.csv2(tb, .pathName(name))
    cat(.pathName(name), "is done o_O\n")
}

setFolder <- function(f) .folder <<- f
