#Demo Screening protein interaction databases

#################################################################
###Automatic screening of protein-protein interaction database###
#################################################################

########
#Download interactions from BioGRID: https://downloads.thebiogrid.org/BioGRID  
#We used: -->Current-Release -->BIOGRID-ORGANISM-3.5.169.tab2.zip
########
BioGridHuman<-read.delim("BIOGRID-ORGANISM-Homo_sapiens-3.5.168.tab2.txt")
Siegle2018<-c("WNT1", "WNT2", "WNT3", "WNT8A", "WNT10A", "WNT10B", "WNT4", "WNT5A", "WNT5B", "WNT6", "WNT7A", "WNT7B", "WNT11", "WNT2B", "WNT9B", "AXIN1", "GSK3B", "APC", "GSK3B", "CSNK1A1", "PTPA", "CTNNB1", "HNF4A", "HNF1A", "FOXO1", "FOXO3", "RHOA", "RAC1", "MAP3K1", "MAPK8", "MAPK9", "PRKCE", "PRKCZ", "PRKCA", "PRKCD", "PRKCB", "PRKCI", "PRKCQ", "PRKCH", "IGF1", "IGF2", "IRS1", "PIK3CA", "PI3KCB", "PIK3CD", "PIK3CG", "AKT1", "TSC2", "MTOR", "RPTOR", "DEPTOR", "MLST8", "RPS6KB1", "KRAS", "NRAS", "HRAS", "RAF1", "BRAF", "MAPK3", "MAPK1", "MTOR", "RICTOR", "MAPKAP1", "MLST8", "DEPTOR", "TELO2")      

HumanOfficialSymbolInteractorA<-BioGridHuman[8]
HumanInteractorA<-table(unlist(HumanOfficialSymbolInteractorA))
HumanOfficialSymbolInteractorB<-BioGridHuman[9]
HumanInteractorB<-table(unlist(HumanOfficialSymbolInteractorB))
HumanInteractorA1<-HumanInteractorA[Siegle2018]
HumanInteractorB1<-HumanInteractorB[Siegle2018]
BioGridInteractionsSiegle2018<-cbind(HumanInteractorA1, HumanInteractorB1)
print("required run time: 7.192 seconds")
write.csv(BioGridInteractionsSiegle2018, "AutomaticScreeningDB_HumanInteractionsBioGrid_Siegle2018.csv")
