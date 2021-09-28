library(igraph)
library(gtools)
library(BoolNet)

conv2adjmat <- function(network, inputcorrected = FALSE){
  "Converts an SBML object to adjacency matrix. 
  If inputcorrected = T, all input edges are set to zero. 
  A vertex v is said to be an input if it is only regulated by itself, 
  meaning the sum of column v in the adjacency matrix is one, with the only non-zero entry 
  being at position [v,v]."
  adjmat <- sapply(network$interactions, function(gene) {v <- rep(0,length(network$genes)); 
  v[gene$input] <- 1; return(v)})
  if (inputcorrected == TRUE){
    for (d in 1:dim(adjmat)[1]){
      if (adjmat[d,d] >= 1){adjmat[d,d] <- 1}
    }
    for (col in 1:dim(adjmat)[2]){
      if (sum(adjmat[,col]) == 1 & adjmat[col,col] == 1){
        adjmat[col,col] <-0
      }
    }
  }
  return(adjmat)
}

net<- loadNetwork("Siegle2018.txt") #load the network you want to analyze
  network <- net
  adjmat <- conv2adjmat(network)
  graph <- graph_from_adjacency_matrix(adjmat)

DiameterNet <- igraph::diameter(graph, directed = TRUE, unconnected = TRUE)
#Diameter of the original networks
DiameterNet 

DiameterAfterRemoval <- rep(NA, length(network$genes))
adjmat <- conv2adjmat(network)
graph <- graph_from_adjacency_matrix(adjmat)
  
#Remove every gene in network once and recalculate diameter
  for (g in 1:length(network$genes)){
    adjmatAfterRemoval <- adjmat[-g,-g]
    graphAfterRemoval <- graph_from_adjacency_matrix(adjmatAfterRemoval)
    DiameterAfterRemoval[g] <- igraph::diameter(graphAfterRemoval, directed = TRUE, unconnected = TRUE)
    names(DiameterAfterRemoval) <- network$genes
  }
#Diameter after removal of each node
DiameterAfterRemoval




