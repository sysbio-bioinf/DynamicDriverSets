#Demo Removal of superfluous nodes

#####################################################
###Network reduction by removing superfluous nodes###
#####################################################
readNetwork <- function(nwFileName, nwName) {
  inFile <- paste(nwFileName,sep="")
  return(read.csv(inFile, stringsAsFactors=FALSE))
}

simplify <- function(genes, rules){
  srules <- list()
  for (r  in 1:length(rules)) {
    rule <- gsub(" ", "", rules[r])
    rule <- gsub("&", ",",rule, fixed=TRUE)
    rule <- gsub("|", ",",rule, fixed=TRUE)
    rule <- gsub("(", "", rule, fixed=TRUE)
    rule <- gsub(")", "", rule, fixed=TRUE)
    rule <- gsub("!","", rule, fixed=TRUE)
    srules[r] <- list(which(genes %in% strsplit(rule,",")[[1]]))
  }
  return (srules)
}

removeOutnodes <- function(network, name) {
  ccNw <- readNetwork(network, name)
  ccGenes <- ccNw[,1]
  print(paste("Genes: ", paste(ccGenes,collapse=", ")))
  ccRules <- ccNw[,2]
  ccInputs <- simplify(ccGenes, ccRules)
  sr <- simplify(ccGenes,ccRules)
  names(sr) <- ccGenes
  tsr <- table(unlist(sr))
  n <- length(sr)
  while (length(tsr) < n) {
    n <- length(tsr)
    x <- 1:length(sr)
    y <- x[-as.integer(names(tsr))]
    print(y)
    sr[y] <- NA
    tsr <- table(unlist(sr))
  }
  
  srem <- ccNw[sapply(sr,function(s) { sum(is.na(s))==0 }),]
  writeNetwork(paste("reduced_",network, sep=""), srem)
  return(srem)
}

writeNetwork <- function(nwFileName, network) {
  outFile <- paste(nwFileName,sep="")
  return(write.csv(network,outFile,quote=FALSE, row.names=FALSE))
}

nwFile <- "Siegle2018.txt"
srem <- removeOutnodes(nwFile,"")
print(srem)
print("required run time: 0.030 seconds")
