#############################################################
#################   Table 2 for Merging   ###################
###################### twotgtable_db ########################
#############################################################

#Load Tissue Lists
filename <- (read.table(file = "/Users/Admin/Desktop/R_course ISB Project/Code/HPA_Tissue_Lists/HPA_Tissues_10.1/HPA_Tongue_Elevated.tsv", sep = "\t", header = TRUE))
tissue <- as.character(filename$Gene)


############## MAKING DATA FRAME ################
GeneSets = c("KEGG", "GO_BP", "REACTOME", "GO_CC", "BIOCARTA", "GO_MF")
twotgtable_db<-as.data.frame(matrix(nrow = length(tissue), ncol = 2+(length(GeneSets))))
colnames(twotgtable_db)<-c("Tissue","Elevated_Gene", GeneSets)



############ FILLING FIRST 2 COLUMNS ############
#Fill tissue name
for (i in 1:length(tissue)) {
  twotgtable_db$Tissue[i]<-"Tongue"
}
#Fill gene name
for (i in 1:length(tissue)) {
  twotgtable_db$Elevated_Gene[i]<-tissue[i]
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
tgtable_db<-rbind(tgtable_db, twotgtable_db)

#Load next tissue filename, change tissue in line 21, run Table 2 for Merging section again


write.csv(x = tgtable_db, file = "./HPA_Tissues_10.1/rshinytable_Elevated.csv")






































#############################################################
###############   Tissue Bias Database Code   ###############
##############    MS Written July 19 2022         #########
#############################################################

#Load Tissue Lists
filename <- (read.table(file = "/Users/Admin/Desktop/R_course ISB Project/Code/HPA_Tissue_Lists/HPA_Tissues_10.1/HPA_ThyroidGland_Elevated.tsv", sep = '\t', header = TRUE))
tissue <- as.character(filename$Gene)

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
GO_BP<-C5[C5$gs_subcat=="GO:BP",]
GO_CC<-C5[C5$gs_subcat=="GO:CC",]
GO_MF<-C5[C5$gs_subcat=="GO:MC",]


#Pull out genes of collections
collectionBIOCARTA<-BIOCARTA$human_gene_symbol
collectionKEGG<-KEGG$human_gene_symbol
collectionREACTOME<-REACTOME$human_gene_symbol
collectionGO_BP<-GO_BP$human_gene_symbol
collectionGO_CC<-GO_CC$human_gene_symbol
collectionGO_MF<-GO_MF$human_gene_symbol



############## MAKING DATA FRAME ################
GeneSets = c("KEGG", "GO_BP", "REACTOME", "GO_CC", "BIOCARTA", "GO_MF")
tgtable_db<-as.data.frame(matrix(, nrow = length(tissue), ncol = 2+(length(GeneSets))))
colnames(tgtable_db)<-c("Tissue","Elevated_Gene", GeneSets)



############ FILLING FIRST 2 COLUMNS ############
#Fill tissue name
for (i in 1:length(tissue)) {
  tgtable_db$Tissue[i]<-"thyroid"
}
#Fill gene name
for (i in 1:length(tissue)) {
  tgtable_db$Gene[i]<-tissue[i]
}



################## INTERSECT ###################
intersection <- vector(mode='character', length(tissue))


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
