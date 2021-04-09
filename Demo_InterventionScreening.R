
library("BoolNet")
boolNetwork <- loadNetwork("Siegle2018.txt" ,symbolic=T)
boolNetwork
InterventionNode<- c("IGF")

print("print: intervention target: IGF")

InterventionAttrsKo <- function(boolNetwork, InterventionNode) {
  
  id <- which(boolNetwork$genes == InterventionNode)
  
  sptAttrs <- getAttractors(boolNetwork, method="sat.exhaustive")
  pertKo<-fixGenes(boolNetwork, InterventionNode, 0)
  pertKoAttrs <- getAttractors(pertKo,method="sat.exhaustive")
  pertOe<-fixGenes(boolNetwork, InterventionNode, 1)
  pertOeAttrs <- getAttractors(pertOe,method="sat.exhaustive")
  print("Intervention Attrs Ko: ")
  print(sapply(pertKoAttrs$attractors,nrow))
  print("Intervention Attrs Oe: ")
  print(sapply(pertOeAttrs$attractors,nrow))
  print("Exh Attrs")
  print(sapply(sptAttrs$attractors,nrow))
  missingAttrs <- list()
  print("Missing Attrs")
  inKO <- sapply(sptAttrs$attractors, function(attr) any(sapply(pertKoAttrs$attractors, function(koAttr) identical(attr[,-id],koAttr[,-id]))))
  inOE <- sapply(sptAttrs$attractors, function(attr) any(sapply(pertOeAttrs$attractors, function(oeAttr) identical(attr[,-id],oeAttr[,-id]))))
  missing <- !(inKO | inOE)
  print(missing)
  return (sptAttrs$attractors[missing])
}


print("Missing attractors after interventions:")
missing<-InterventionAttrsKo(boolNetwork, InterventionNode)
print(missing)

#####Ko in Exh
pertKo<-fixGenes(boolNetwork, InterventionNode, 0)
pertKoAttrs <- getAttractors(pertKo,method="sat.exhaustive")
pertKoAttrs$attractors


InterventionAttrsKo <- function(boolNetwork, InterventionNode) {
  
  id <- which(boolNetwork$genes == InterventionNode)
  
  sptAttrs <- getAttractors(boolNetwork, method="sat.exhaustive")
  pertKo<-fixGenes(boolNetwork, InterventionNode, 0)
  pertKoAttrs <- getAttractors(pertKo,method="sat.exhaustive")
  pertOe<-fixGenes(boolNetwork, InterventionNode, 1)
  pertOeAttrs <- getAttractors(pertOe,method="sat.exhaustive")
  print("Intervention Attrs Ko: ")
  print(sapply(pertKoAttrs$attractors,nrow))
  print("Intervention Attrs Oe: ")
  print(sapply(pertOeAttrs$attractors,nrow))
  print("Exh Attrs")
  print(sapply(sptAttrs$attractors,nrow))
  missingAttrs <- list()
  print("Missing Attrs")
  inExh <- sapply(pertKoAttrs$attractors, function(attr) any(sapply(sptAttrs$attractors, function(sptAttr) identical(attr[,-id],sptAttr[,-id]))))
  missing <- !(inExh)
  print(missing)
  return (pertKoAttrs$attractors[missing])
}

print("Additional attractors after knockout:")
KoInExh<-InterventionAttrsKo(boolNetwork, InterventionNode)
print(KoInExh)

#####Oe in Exh
pertOe<-fixGenes(boolNetwork, InterventionNode, 1)
pertOeAttrs <- getAttractors(pertOe,method="sat.exhaustive")
pertOeAttrs$attractors


InterventionAttrsKo <- function(boolNetwork, InterventionNode) {
  
  id <- which(boolNetwork$genes == InterventionNode)
  
  sptAttrs <- getAttractors(boolNetwork, method="sat.exhaustive")
  pertKo<-fixGenes(boolNetwork, InterventionNode, 0)
  pertKoAttrs <- getAttractors(pertKo,method="sat.exhaustive")
  pertOe<-fixGenes(boolNetwork, InterventionNode, 1)
  pertOeAttrs <- getAttractors(pertOe,method="sat.exhaustive")
  print("Intervention Attrs Ko: ")
  print(sapply(pertKoAttrs$attractors,nrow))
  print("Intervention Attrs Oe: ")
  print(sapply(pertOeAttrs$attractors,nrow))
  print("Exh Attrs")
  print(sapply(sptAttrs$attractors,nrow))
  missingAttrs <- list()
  print("Missing Attrs")
  inExh <- sapply(pertOeAttrs$attractors, function(attr) any(sapply(sptAttrs$attractors, function(sptAttr) identical(attr[,-id],sptAttr[,-id]))))
  missing <- !(inExh)
  print(missing)
  return (pertOeAttrs$attractors[missing])
}

print("Additional attractors after overexpression:")
OeInExh<-InterventionAttrsKo(boolNetwork, InterventionNode)
print(OeInExh)

#####Oe in Ko
InterventionAttrsKo <- function(boolNetwork, InterventionNode) {
  
  id <- which(boolNetwork$genes == InterventionNode)
  
  sptAttrs <- getAttractors(boolNetwork, method="sat.exhaustive")
  pertKo<-fixGenes(boolNetwork, InterventionNode, 0)
  pertKoAttrs <- getAttractors(pertKo,method="sat.exhaustive")
  pertOe<-fixGenes(boolNetwork, InterventionNode, 1)
  pertOeAttrs <- getAttractors(pertOe,method="sat.exhaustive")
  print("Intervention Attrs Ko: ")
  print(sapply(pertKoAttrs$attractors,nrow))
  print("Intervention Attrs Oe: ")
  print(sapply(pertOeAttrs$attractors,nrow))
  print("Exh Attrs")
  print(sapply(sptAttrs$attractors,nrow))
  missingAttrs <- list()
  print("Missing Attrs")
  inKO <- sapply(pertOeAttrs$attractors, function(attr) any(sapply(pertKoAttrs$attractors, function(KoAttr) identical(attr[,-id], KoAttr[,-id]))))
  missing <- !(inKO)
  print(missing)
  return (pertOeAttrs$attractors[missing])
}

print("Comparison knockout with overexpression: attractors after overexpression in the set of attractors after knockout")
OeInKo<-InterventionAttrsKo(boolNetwork, InterventionNode)
print(OeInKo)

###Ko in Oe
InterventionAttrsKo <- function(boolNetwork, InterventionNode) {
  
  id <- which(boolNetwork$genes == InterventionNode)
  
  sptAttrs <- getAttractors(boolNetwork, method="sat.exhaustive")
  pertKo<-fixGenes(boolNetwork, InterventionNode, 0)
  pertKoAttrs <- getAttractors(pertKo,method="sat.exhaustive")
  pertOe<-fixGenes(boolNetwork, InterventionNode, 1)
  pertOeAttrs <- getAttractors(pertOe,method="sat.exhaustive")
  print("Intervention Attrs Ko: ")
  print(sapply(pertKoAttrs$attractors,nrow))
  print("Intervention Attrs Oe: ")
  print(sapply(pertOeAttrs$attractors,nrow))
  print("Exh Attrs")
  print(sapply(sptAttrs$attractors,nrow))
  missingAttrs <- list()
  print("Missing Attrs")
  inOE <- sapply(pertKoAttrs$attractors, function(attr) any(sapply(pertOeAttrs$attractors, function(oeAttr) identical(attr[,-id],oeAttr[,-id]))))
  missing <- !(inOE)
  print(missing)
  return (pertKoAttrs$attractors[missing])
}

print("Comparison overexpression with knockout: attractors after knockout in the set of attractors after overexpression")
KoInOe<-InterventionAttrsKo(boolNetwork, InterventionNode)
print(KoInOe)

print("required run time: 0.264 seconds")