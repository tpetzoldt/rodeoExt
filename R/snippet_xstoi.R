#tables$xstoi <- read.table("lake/rodeo/xstoi.txt", header=TRUE, sep="\t", as.is=TRUE, colClasses = "character")

## new version with aggregated SPOMD and SPOMI compartments
#tables$stoi <- NULL
#tables$stoi <- as.stoi(tables$xstoi)
#tables$xstoi <- NULL
#write.table(tables$stoi, file="clipboard", sep="\t", row.names=FALSE)
