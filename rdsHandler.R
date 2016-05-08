## RDS handler - 07/05-16

.path <- ""

.loadRDS <- function(x) {
        p <- file.path(.path, x)
        tmp <- readRDS(p)
}

.rdsFilter <- function(x) {
    x[grep("\\.rds$", x)]
}

.strpExtn <- function(x) {
    sub("\\.rds$", "", x)
}

# Interface
setPath <- function(path) {
    use(.GlobalEnv, reInit = FALSE)
    .path <<- path
    return(.rdsFilter(list.files(path)))
}

getVars <- function() {
    fs <- .rdsFilter(list.files(.path))
    ls <- sapply(fs, .loadRDS)
    names(ls) <- .strpExtn(names(ls))
    ls
}

saveVars <- function(ls) {
    Map(function(val, nam) saveRDS(val, file.path(.path, nam)),
        ls, paste0(names(ls), ".rds"))
}
