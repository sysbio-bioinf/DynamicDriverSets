#Demo exhaustive approach


###################################
###Identification of implicants###
##################################

#########################
###Exhaustive approach###
#########################

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

testGeneset <- function(ccGenes,ccRules,ccInputs,inputGenes, verbose=TRUE) {
  determined <- TRUE
  geneMapping <- list()
  if (verbose)
    print(paste("Selected: ", paste(ccGenes[inputGenes],collapse=", ")))
  k <- length(inputGenes)
  lastbin <- rep(-1,k)
  for (finiteStates in 0:(2**k-1)) {
    bin <- rev(as.integer(intToBits(finiteStates))[1:k])
    if (identical(bin[1:length(lastbin)],lastbin))
      next
    firstL <- 0
    for (firstl in 1:k) {
      firstL <- firstl
      ccState <- initcircuit(ccGenes, rep(-1,length=length(ccGenes)))
      ccState[inputGenes[1:firstL]] <- bin[1:firstL]
      booleanState <- FALSE
      statetransitions <- list()
      for (nextStep in 1:20) {
        statetransitions[nextStep] <- list(unname(unlist(ccState)))
        ccState <- sufficientEvalcircuit(ccGenes,ccRules,ccInputs, ccState)
        if (min(as.integer(ccState)) >= 0) {
          booleanState <- TRUE
          break
        }
      }
      if (booleanState) {
        statetransitions[nextStep+1] <- list(unname(unlist(ccState)))
        break
      }
    }
    if (booleanState) {
      lastbin <- bin[1:firstL]
    } else {
      determined=FALSE
      return (NA)
    }
    gs <- matrix(unlist(statetransitions),
                 ncol = length(ccGenes), byrow = TRUE,  dimnames=list(list(),ccGenes))
    if (verbose) {
      initState <- initcircuit(ccGenes, rep(-1,length=length(ccGenes)))
      initState[inputGenes[1:firstL]] <- bin[1:firstL]
      print(unlist(initState[inputGenes[1:firstL]]))
      print(gs)
    }
    geneMapping[paste(c(lastbin,rep(-1,k-length(lastbin))), collapse=",")] <- list(gs)
  }
  return (geneMapping)
}

initcircuit <- function(genes, stateValues){
  nextState <- list()
  for (i in 1:length(stateValues)){
    nextState[genes[i]] <- stateValues[i]
  }
  return (nextState)
}

sufficientEvalcircuit <- function(genes, rules, inputs, states) {
  nextState <- list()
  for (i in 1:length(genes)) {
    assign(genes[i], states[[i]])
  }
  for (i in 1:length(genes)) {
    ruleInputs <- inputs[[i]]
    ruleInputsState <- states[ruleInputs]
    if (min(as.integer(ruleInputsState))>=0) {
      nextState[genes[i]] <- eval(parse(text=rules[i]))
    } else {
      x <- which(ruleInputsState < 0)
      k <- length(x)
      bin <- as.integer(intToBits(0))
      ruleInputsState[x] <- bin[1:k] 
      evalGene <- evalGeneCircuit(genes, ruleInputs, rules[i], ruleInputsState)
      nextState[genes[i]] <- evalGene
      for (tt in 1:(2**k-1)) {
        bin <- as.integer(intToBits(tt))
        ruleInputsState[x] <- bin[1:k] 
        if (evalGene != evalGeneCircuit(genes, ruleInputs, rules[i], ruleInputsState)) {
          nextState[genes[i]] <- states[genes[i]]
          break
        }
      }
    }
  }
  return (nextState)
}

evalGeneCircuit <- function(genes, geneInputs, rule, geneStates) {
  for (i in 1:length(geneInputs)) {
    gi <- genes[geneInputs[i]]
    assign(gi, as.logical(geneStates[i]))
  }
  nextState <-  eval(parse(text=rule))
  return (nextState)
}

testNetwork <- function(network, name, verbose=FALSE,  kmax=20) {
  ccNw <- readNetwork(network, name)
  ccGenes <- ccNw[,1]
  print(paste("Genes: ", paste(ccGenes,collapse=", ")))
  ccRules <- ccNw[,2]
  ccInputs <- simplify(ccGenes, ccRules)
  for (k in 1:kmax) {
    print(paste("k:", k))
    genesets <- combn(1:length(ccGenes),k, simplify=FALSE)
    selectedSets <- sapply(genesets, function(geneset) {
      geneset <- unlist(geneset)
      a <- paste(ccGenes[geneset],collapse=", ")
      l <- list(testGeneset(ccGenes,ccRules,ccInputs,geneset, verbose))
      names(l) <- a
      return(l)
    })
    selectedSets <- selectedSets[!is.na(selectedSets)]
    if (verbose) {
      print(selectedSets)
    }
    if (length(selectedSets)>0)
      break
  }
  return(selectedSets)
}

selecteGenesSet <- function(network, name, k=20, all=FALSE) {
  ccNw <- readNetwork(network, name)
  ccGenes <- ccNw[,1]
  k <- min (k,length(ccGenes))
  print(paste("Genes: ", paste(ccGenes,collapse=", ")))
  ccRules <- ccNw[,2]
  ccInputs <- simplify(ccGenes, ccRules)
  ct <- ccInputs
  res <- rep(0,k)
  ctGenes <- c()
  for (i in 1:k) {
    xt <- table(unlist(ct))
    st <- names(which(xt==max(xt)))[1]
    if (st <1){
      res <- res[1:i]
      break
    }
    ct[as.integer(st)] <- c(-i)
    ct <- sapply(ct,function(cn) {cn[cn!=st]})
    res[i] <- st
    ctGenes <- c(ctGenes,as.integer(st))
    selectedSet <- testGeneset(ccGenes,ccRules,ccInputs,ctGenes, verbose=FALSE)
    if (!all & length(selectedSet[!is.na(selectedSet)]))
      break
  }
  res <- res[res>0]
  names(res) <- ccGenes[as.integer(res)]
  return (as.integer(res))
}

nwFile <- "toymodelgraph.txt"
selectedSet <- selecteGenesSet(nwFile, nwFile, k=20)
combSet <- testNetwork(nwFile,nwFile)
print(names(combSet))
print("required run time: 6060.506 seconds")
