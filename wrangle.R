import(plyr)
onlyFirst <- function(xx, col) {
    ddply(xx, col, function(x) x[1,])
}

allUnique <- function(x) !any(duplicated(x))

headalicious <- function(x, n = 8) { 
    s <- sample(1:nrow(x), size = 8)
    x[s, ]
}

filtr <- function(re, x) x[!grepl(re, x, perl = TRUE)]
