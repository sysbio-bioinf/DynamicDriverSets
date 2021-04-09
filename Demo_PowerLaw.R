#Demo Testing for Power Law distribution

###########################################################################
###Identification of scale-free network topology and static network hubs###
###########################################################################
if(!require("poweRlaw",character.only = TRUE)) install.packages("poweRlaw")
library("poweRlaw",character.only = TRUE)

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


countDegree <- function(network, name, noOfSims = 500, noOfThreads=8 ) {
  ccNw <- readNetwork(network, name)
  ccGenes <- ccNw[,1]
  ccRules <- ccNw[,2]
  sr <- simplify(ccGenes,ccRules)
  degs <- matrix(0,ncol=6, nrow=length(ccGenes), dimnames=list(ccGenes,list("out","inp","loop","total","Z (out)", "Z (total)")))
  degs[,1] <- sapply(1:length(ccGenes),function(g) { length(sr[[g]]) })
  degs[,2] <- c(tabulate(unlist(sr)), rep(0,length(ccGenes)-max(unlist(sr))))
  degs[,3] <- sapply(1:length(ccGenes), function(g) { if (g %in% sr [[g]]) {return(1)} else {return(0)} } )
  degs[,1] <- degs[,1] - degs[,3]
  degs[,2] <- degs[,2] - degs[,3]
  degs[,4] <-  degs[,1] + degs[,2] + degs[,3]
  degMean <- mean(degs[,1])
  degSd <- sd(degs[,1])
  degs[,5] <- round((degs[,1] - degMean)/degSd,2)
  degMean <- mean(degs[,4])
  degSd <- sd(degs[,4])
  degs[,6] <- round((degs[,4] - degMean)/degSd,2)
  degtable <- degs
  degtable[degtable==0] <- NA
  m <- degs[,4]
  m <- m[m>0]
  m_pl <- displ$new(m)
  est <- estimate_xmin(m_pl)
  if(is.na(est$xmin)) {
    print("failed to set model parameters")
    pvalue <- "failed to set model parameters"
  } else {
    m_pl$setXmin(est)
    bt_pl <- bootstrap_p(m_pl, no_of_sims=noOfSims, threads=noOfThreads)
    pvalue <- bt_pl$p
  }
  return(list(bootstrap=bt_pl, degrees=degs))
}

network <- "Siegle2018.txt"
Zscore <- countDegree(network,network, noOfSims=100, noOfThreads=4)
print(Zscore)
print("required run time: 1.802 seconds")
#############
#Note, that genes/proteins with a score Z(total)>2.5 are defined as hub nodes.
############
