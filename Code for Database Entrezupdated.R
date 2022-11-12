#############################################################
#################   Table 2 for Merging   ###################
####################   twotgtable_db   ######################
############## GH edited for Entrez 12/3/19 #################
#############################################################

#Load Tissue Lists
#filename <- (read.table(file = '~/ISB/HPA_Tissues_10.1/HPA_Vagina_Enriched.tsv', sep = '\t', header = TRUE))
#tissue <- as.character(filename)

##New loading Entrez because RData, not tsv
load("~/ISB/HPA_Tissues_Entrez_11.12/Vagina_Enriched_Genes.Rdata")
tissue <-Vagina_Enriched_Genes

############## MAKING DATA FRAME ################
GeneSets = c("GO_BP", "GO_MF", "GO_CC", "REACTOME", "KEGG", "BIOCARTA")
twotgtable_db<-as.data.frame(matrix(, nrow = length(tissue), ncol = 2+(length(GeneSets))))
colnames(twotgtable_db)<-c("Tissue","Enriched_Gene", GeneSets)



############ FILLING FIRST 2 COLUMNS ############
#Fill tissue name
for (i in 1:length(tissue)) {
  twotgtable_db$Tissue[i]<-"Vagina"
}
#Fill gene name
for (i in 1:length(tissue)) {
  twotgtable_db$Enriched_Gene[i]<-tissue[i]
}



################## INTERSECT ###################
intersection <- vector(mode='character', length(tissue))

################# FILL MATRIX ##################
#Fill TRUE/FALSE    #Integrate into intersect for loop

#KEGG
for (i in 1:length(tissue)) { #for indexes 1 through the length of tissue
  x <- intersect(tissue[i],collectionKEGG) #call intersection between the tissue gene and the collection x
  twotgtable_db$KEGG[i]<-if(length(x)>0) { #fill collection column with if else  #if length intersection >0
    print(T)
  } else {
    print (F)
  }
}



#GO_BP
for (i in 1:length(tissue)) { 
  x <- intersect(tissue[i],collectionGO_BP) 
  twotgtable_db$GO_BP[i]<-if(length(x)>0) {
    print(T)
  } else {
    print (F)
  }
}



#REACTOME
for (i in 1:length(tissue)) { 
  x <- intersect(tissue[i],collectionREACTOME) 
  twotgtable_db$REACTOME[i]<-if(length(x)>0) {
    print(T)
  } else {
    print (F)
  }
}



#GO_CC
for (i in 1:length(tissue)) { 
  x <- intersect(tissue[i],collectionGO_CC) 
  twotgtable_db$GO_CC[i]<-if(length(x)>0) {
    print(T)
  } else {
    print (F)
  }
}



#BIOCARTA
for (i in 1:length(tissue)) { 
  x <- intersect(tissue[i],collectionBIOCARTA) 
  twotgtable_db$BIOCARTA[i]<-if(length(x)>0) {
    print(T)
  } else {
    print (F)
  }
}



#GO_MF
for (i in 1:length(tissue)) { 
  x <- intersect(tissue[i],collectionGO_MF) 
  twotgtable_db$GO_MF[i]<-if(length(x)>0) {
    print(T)
  } else {
    print (F)
  }
}


############# MERGE TWO TABLES ############
tgtable_db<-rbind(tgtable_db,twotgtable_db)

#Load next tissue filename, change tissue in line 21, run Table 2 for Merging section again


write.csv(tgtable_db, "~/ISB/Figures/tissueEnrichedgenestable_db.csv")
save(tgtable_db, file="~/ISB/Figures/tissueEnrichedgenestable_db.RData")





























#############################################################
###############   Tissue Bias Database Code   ###############
##############    GH Written August 19 2018         #########
#############################################################

#Load Tissue Lists
#filename <- (read.table(file = '~/ISB/HPA_Tissues_10.1/HPA_Adipose_Enriched.tsv', sep = '\t', header = TRUE))
#tissue <- as.character(filename$Gene)

##New loading Entrez because RData, not tsv
load("~/ISB/HPA_Tissues_Entrez_11.12/Adipose_Enriched_Genes.Rdata")
tissue <-Adipose_Enriched_Genes

# Load Gene Lists of Interest
library(msigdbr)



############## LOAD GENE SET SUBCOLLECTIONS #############
GeneSets = c("H","C2","C5","C6","C7")
for (x in GeneSets) {
  assign(x, msigdbr(species = "Homo sapiens", category = x))}

#For Each List, we need to go in and all all the sub categories we will look at
BIOCARTA<-C2[C2$gs_subcat=="CP:BIOCARTA",]
KEGG<-C2[C2$gs_subcat=="CP:KEGG",]
REACTOME<-C2[C2$gs_subcat=="CP:REACTOME",]
GO_BP<-C5[C5$gs_subcat=="BP",]
GO_CC<-C5[C5$gs_subcat=="CC",]
GO_MF<-C5[C5$gs_subcat=="MF",]


#Pull out genes of collections
collectionBIOCARTA<-BIOCARTA$entrez_gene
collectionKEGG<-KEGG$entrez_gene
collectionREACTOME<-REACTOME$entrez_gene
collectionGO_BP<-GO_BP$entrez_gene
collectionGO_CC<-GO_CC$entrez_gene
collectionGO_MF<-GO_MF$entrez_gene



############## MAKING DATA FRAME ################
GeneSets = c("GO_BP", "GO_MF", "GO_CC", "REACTOME", "KEGG", "BIOCARTA")
tgtable_db<-as.data.frame(matrix(, nrow = length(tissue), ncol = 2+(length(GeneSets))))
colnames(tgtable_db)<-c("Tissue","Enriched_Gene", GeneSets)



############ FILLING FIRST 2 COLUMNS ############
#Fill tissue name
for (i in 1:length(tissue)) {
  tgtable_db$Tissue[i]<-"Adipose"
}
#Fill gene name
for (i in 1:length(tissue)) {
  tgtable_db$Enriched_Gene[i]<-tissue[i]
}



################## INTERSECT ###################
intersection <- vector(mode='character', length(tissue))

#for (i in 1:length(tissue)) {
# x <- intersect(tissue[i],collectionKEGG)
#intersection <- if(length(x)>0) {
# print(T)
#} else {
# print (F)
#}
#}



################# FILL MATRIX ##################
#Fill TRUE/FALSE    #Integrate into intersect for loop

#KEGG
for (i in 1:length(tissue)) { #for indexes 1 through the length of tissue
  x <- intersect(tissue[i],collectionKEGG) #call intersection between the tissue gene and the collection x
  tgtable_db$KEGG[i]<-if(length(x)>0) { #fill collection column with if else  #if length intersection >0
    print(T)
  } else {
    print (F)
  }
}



#GO_BP
for (i in 1:length(tissue)) { 
  x <- intersect(tissue[i],collectionGO_BP) 
  tgtable_db$GO_BP[i]<-if(length(x)>0) {
    print(T)
  } else {
    print (F)
  }
}



#REACTOME
for (i in 1:length(tissue)) { 
  x <- intersect(tissue[i],collectionREACTOME) 
  tgtable_db$REACTOME[i]<-if(length(x)>0) {
    print(T)
  } else {
    print (F)
  }
}



#GO_CC
for (i in 1:length(tissue)) { 
  x <- intersect(tissue[i],collectionGO_CC) 
  tgtable_db$GO_CC[i]<-if(length(x)>0) {
    print(T)
  } else {
    print (F)
  }
}



#BIOCARTA
for (i in 1:length(tissue)) { 
  x <- intersect(tissue[i],collectionBIOCARTA) 
  tgtable_db$BIOCARTA[i]<-if(length(x)>0) {
    print(T)
  } else {
    print (F)
  }
}



#GO_MF
for (i in 1:length(tissue)) { 
  x <- intersect(tissue[i],collectionGO_MF) 
  tgtable_db$GO_MF[i]<-if(length(x)>0) {
    print(T)
  } else {
    print (F)
  }
}

