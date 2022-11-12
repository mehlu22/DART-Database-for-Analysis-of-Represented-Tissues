#############################################################
#####   Identifying Missing Genes in GeneSets    ############
#####    AGP & GH Written March 7th 2018         ############
#############################################################

#Load Tissue Lists
load("~/ISB/Coding/Tissue_Elevated_Genes.RData")

# Load Gene Lists of Interest

library(msigdbr)

##ake a separate Matrix for each Category
#Create a list for each different MSigDB Category
GeneSets = c("H","C2","C5","C6","C7")
for (x in GeneSets) {
  assign(x, msigdbr(species = "Homo sapiens", category = x))}

#For Each List, we need to go in and adll all the sub categories we will look at
CP<-C2[C2$gs_subcat=="CP",]
CP_BIOCARTA<-C2[C2$gs_subcat=="CP:BIOCARTA",]
CP_KEGG<-C2[C2$gs_subcat=="CP:KEGG",]
CP_REACTOME<-C2[C2$gs_subcat=="CP:REACTOME",]
BP<-C5[C5$gs_subcat=="GO:BP",]
CC<-C5[C5$gs_subcat=="GO:CC",]
MF<-C5[C5$gs_subcat=="GO:MF",]

names(GeneSets_Sublist)<-c("CP","CP:BIOCARTA","CP:KEGG","CP:REACTOME","BP","CC","MF")

#Startng with the first pathway

#expand it all the subsets we will look at
GeneSets = c("H","C2","CP","CP:BIOCARTA","CP:KEGG","CP:REACTOME","C5","BP","CC","MF","C6","C7")

Results_Elevated<-as.data.frame(matrix(, nrow = length(names(Elevated_Genes)), ncol = 1+2*(length(GeneSets)))) #well need to increase this to 2+ Number of gene sets we want to loook at


colnames(Results_Elevated)<-c("N_Elevated",GeneSets,paste0("Percent_", GeneSets))

rownames(Results_Elevated)<-names(Elevated_Genes)

#First step: N Genes
for (i in 1:length(Elevated_Genes)) {
  Results_Elevated$N_Elevated[i]<-as.numeric(length(Elevated_Genes[[i]]))
  }
#For Each Gene Set: Normal
#H
for (i in 1:length(Elevated_Genes)) {
  Results_Elevated$H[i]<-as.numeric(length(intersect(H$human_gene_symbol, Elevated_Genes[[i]])))
  }
Results_Elevated$Percent_H<-Results_Elevated$H/Results_Elevated$N_Elevated


#This now works for 1 gene set: H

#Next steps are to change up this code so it works for the other gene sets, and to do this for the enriched genes as well