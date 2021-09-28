library("BoolNet")
library("DescTools")
library("gtools")

# Get *all* canalyzing variables of a given function
#-> Count how often a variable is canalyzing across all functions of the given network
getallCanalyzingVars <-  function(interaction){
  func <- interaction$func
  inputGeneIndices <- interaction$input
  #If the function has only one input, this must be a canalyzing variable
  if (length(inputGeneIndices)==1){return(inputGeneIndices)} else {
  #Multiple inputs
  input <- expand.grid(rep(list(c(1,0)), log2(length(func))))
  input <- DescTools::Rev(input, margin=1)
  input <- DescTools::Rev(input, margin=2)
  colnames(input) <- inputGeneIndices
  rownames(input) <- seq(1,length(func)) # input rows are now in order of increasing value of binary strings
  allCanalyzingVars <- c() # Append to this vector if a var is canalyzing if given either value 0 or 1
  
  for (i in seq_len(ncol(input))){ #i = 1,2,...,number of input genes
    #print(paste0("Checking input gene ", inputGeneIndices[i]))
    
    #Check if 0 is a canalyzing value for this input variable
    rowindices <- which(input[,i] == 0)
    if (length(unique(func[rowindices])) == 1){
      allCanalyzingVars <- append(allCanalyzingVars, colnames(input[i]))
    }
    #Check if 1 is a canalyzing value for this input variable
    rowindices <- which(input[,i] == 1)
    if (length(unique(func[rowindices])) == 1){
      allCanalyzingVars <- append(allCanalyzingVars, colnames(input[i]))
    }
    
  }
  allCanalyzingVars <- as.numeric(unique(allCanalyzingVars)) #functions that have only 1 input are canalyzing for both 0 and 1 input
  if (length(allCanalyzingVars)>0){return(allCanalyzingVars)}else{
    return(FALSE) # No canalyzing variables present in the function
  }
  }
}


network<- loadNetwork("Siegle2018.txt") #load the network you want to analyze
canalVarCountsByNet <- rep(list(NA), length(network))
#calculate number of canalyzed functions for each node
allgenes <- c()
  size <- length(network$genes)
  interactions <- network$interactions
  canalVarCounter <- rep(0, size)
  for (g in 1:size){
    intsOfGene <- interactions[[g]]
    canalVars <- getallCanalyzingVars(intsOfGene)
    canalVarCounter[canalVars] <- canalVarCounter[canalVars] + 1
  }
  names(canalVarCounter) <- network$genes
  print(canalVarCounter)
  
