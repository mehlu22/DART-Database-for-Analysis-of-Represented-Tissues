#############################################################
################ 2. Table 2 for Merging   ###################
####################   twotgtable_db   ######################
############## GH edited for Entrez 12/3/19 #################
#############################################################

#Load Tissue Lists
filename <- (read.table(file = '~/ISB/HPA_Tissues_10.1/HPA_Vagina_Enriched.tsv', sep = '\t', header = TRUE))
tissue <- as.character(filename)

##New loading Entrez because RData, not tsv
#load("~/ISB/HPA_Tissues_Entrez_11.12/Vagina_Enriched_Genes.Rdata")
#tissue <-Vagina_Enriched_Genes

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
#############   1. Tissue Bias Database Code   ##############
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


































#############################################################
######### 3. Combine percent coverage table    ##############
################    GH Revised 9/11/2020       ##############
#############################################################
#ALREADY loaded gene sets
#Make table
#Then delete extra columns and rename columns
##Merge data tables at the very bottom

############# Make data frame ############
GeneSets = c("GO_BP", "GO_MF", "GO_CC", "REACTOME", "KEGG", "BIOCARTA")

AResults_Enriched2<-as.data.frame(matrix(, nrow = length(names(Enriched_Genes)), ncol = 2+2*(length(GeneSets)))) 

colnames(AResults_Enriched2)<-c("Tissue","N_Enriched",GeneSets,paste0("Percent_", GeneSets))

############# Fill all rows ##############
#Fill tissue name
AResults_Enriched2$Tissue<-names(Enriched_Genes)

#First step: N Genes
for (i in 1:length(Enriched_Genes)) {
  AResults_Enriched2$N_Enriched[i]<-as.numeric(length(Enriched_Genes[[i]]))
}

#For Each Gene Set: Normal
for (i in 1:length(Enriched_Genes)) {
  AResults_Enriched2$BIOCARTA[i]<-as.numeric(length(intersect(BIOCARTA$entrez_gene, Enriched_Genes[[i]])))
}

AResults_Enriched2$Percent_BIOCARTA<-round(AResults_Enriched2$BIOCARTA/AResults_Enriched2$N_Enriched,digits=3)

#Next steps are to change up this code so it works for the other gene sets, and to do this for the Enriched genes as well


############## Clean Up: Merge horizontally #############
### Each row lists coverage of one specific gene AND percent coverage for all genes of that tissue
### (All genes associated with same tissue will repeat same values in percent coverage columns)
AAResults_Enriched2<-AResults_Enriched2[,-c(2:8)]





################################### *Clean Up: Extra* ###################
############## Delete extra rows #############
#AAResults_Enriched2<-AResults_Enriched2[,-c(3:8)]

############## Clear N_Enriched ##############
#First step: N Genes
#for (i in 1:length(Enriched_Genes)) {
  #AAResults_Enriched2$N_Enriched[i]<-NA
#}

############## Rename rows #################
#colnames(AAResults_Enriched2)<-c("Tissue","Enriched_Gene", GeneSets)

############## Merge with Database ###########
#rshinytable<-merge(EnrichedTable_db, AAResults_Enriched2,by="Tissue")



write.csv(rshinytable, "~/ISB/Figures/rshinytable_Enriched.csv")
save(rshinytable, file="~/ISB/Figures/rshinytable_Enriched.RData")
