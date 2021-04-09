#Demo Heuristic approach

###################################
###Identification of implicants###
##################################

########################
###Heuristic approach###
########################

install.packages("combinat")
library("combinat")

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

nextNodeId <- function(init=FALSE) {
  if (init) {
    nodeId <<- 1
  } else {
    nodeId <<- nodeId + 1
  }
  return (nodeId)
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

removeSingle <- function(ct) {
  ct <- sapply(ct,unique)
  num <- which(sapply(1:length(ct), function(ind){length(ct[[ind]])==1 && ct[[ind]]>0 && ct[[ind]]!=ind})==TRUE)
  while (length(num)>0) {
    ind <- num[1]
    pind <- paste("^", ind, "$", sep="")
    print(paste("gene ", ind, " propagates gene ", ct[ind]))
    ct <- sapply(ct,function(rule) {as.integer(gsub(pind, ct[[ind]], rule)) })
    ct[[ind]] <- c(-nextNodeId())
    ct <- sapply(ct,unique)
    num <- which(sapply(1:length(ct), function(ind){length(ct[[ind]])==1 && ct[[ind]]>0 && ct[[ind]]!=ind})==TRUE)
  }
  return(ct)
}

selectGenesSet <- function(network, name, k=20, all=FALSE, verbose=FALSE) {
  nextNodeId(TRUE)
  ccNw <- readNetwork(network, name)
  ccGenes <- ccNw[,1]
  k <- min (k,length(ccGenes))
  print(paste("Network: ", name))
  print(paste("Genes: ", paste(ccGenes,collapse=", ")))
  ccRules <- ccNw[,2]
  ccInputs <- simplify(ccGenes, ccRules)
  ct <- ccInputs
  res <- rep(0,k)
  ctGenes <- c()
  for (i in 1:k) {
    ct <- removeSingle(ct)
    st <- 0
    num <- which(sapply(1:length(ct), function(ind){length(ct[[ind]])==1 && ct[[ind]]==ind})==TRUE)
    if (length(num)>0) {
      st <- num[[1]]
      print(paste("input gene: ", st))
    } else {
      xt <- table(unlist(ct))
      print(xt)
      st <- names(which(xt==max(xt)))[1]
      print(paste("max weight node: ", st))
    }
    if (st <1)
      break
    ct[as.integer(st)] <- c(-nextNodeId())
    ct <- sapply(ct,function(cn) {cn[cn!=st]})
    res[i] <- st
    ctGenes <- c(ctGenes,as.integer(st))
    selectedSet <- testGeneset(ccGenes,ccRules,ccInputs,ctGenes, verbose)
    if (!all & length(selectedSet[!is.na(selectedSet)]))
      break
  }
  res <- res[res>0]
  names(res) <- ccGenes[as.integer(res)]
  return (as.integer(res))
}

solutionSet <- list()

hasSolution <- function(solution, init=FALSE) {
  if (init) {
    solutionSet <<- list()
    return (FALSE)
  } else {
    newSol <- paste(sort(solution), collapse=",")
    if (is.null(solutionSet[[newSol]])) {
      return (FALSE)
    } else {
      return (TRUE)
    }
  }
}

addSolution <- function(solution, value) {
  newSol <- paste(sort(solution), collapse=",")
  solutionSet[newSol] <<- value
}

isSolution <- function(solution) {
  newSol <- paste(sort(solution), collapse=",")
  return (solutionSet[newSol])
}

recursive.selectGenesSet <- function(network, name, k=20, all=FALSE) {
  hasSolution(c(),init=TRUE)
  ccNw <- readNetwork(network, name)
  ccGenes <- ccNw[,1]
  k <- min (k,length(ccGenes))
  print(paste("Genes: ", paste(ccGenes,collapse=", ")))
  ccRules <- ccNw[,2]
  ccInputs <- simplify(ccGenes, ccRules)
  ct <- ccInputs
  ctGenes <- c()
  return (recSelectGeneset(ccGenes,ccRules,ccInputs,ct,ctGenes,k,all))
}

recSelectGeneset <- function(ccGenes,ccRules,ccInputs,ct,ctGenes,k, all) {
  if (k < 1) {
    print("k<1")
    print(unlist(ctGenes))
    return(NA)
  }
  sts <- which(sapply(1:length(ct), function(ind){length(ct[[ind]])==1 && ct[[ind]]==ind})==TRUE)
  if (length(sts)==0) {
    xts <- table(unlist(ct))
    sts <- as.integer(names(which(xts==max(xts))))
  }
  sts <- sts[sts>0]
  if (length(sts)==0) {
    print("no gene found")
    return (NA)
  }
  ctGs <- sapply (sts, function(st, ct, ctGenes, k) {
    ct[st] <- c(-k)
    ct <- sapply(ct,function(cn) {cn[cn!=st]})
    ctGenes <- c(ctGenes,as.integer(st))
    selectedSet <- c()
    if (hasSolution(ctGenes)) {
      print("has solution")
      print(ctGenes)
      return (NA)
    } else {
      print("add solution")
      print(ctGenes)
      addSolution(ctGenes,TRUE)
    }
    selectedSet <- testGeneset(ccGenes,ccRules,ccInputs,ctGenes, verbose=FALSE)
    if (!all & length(selectedSet[!is.na(selectedSet)])>0) {
      return(ctGenes)
    } else {
      return (recSelectGeneset(ccGenes,ccRules,ccInputs,ct,ctGenes,k-1,all))
    }
  }, ct, ctGenes, k)
  return(ctGs)
}

nwFile <- "Siegle2018.txt"
selectedSet <- selectGenesSet(nwFile, nwFile, k=20)
print(selectedSet)
print("required run time: 23.221 seconds")