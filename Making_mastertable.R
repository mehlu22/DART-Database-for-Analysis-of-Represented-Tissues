#############################################################
#####   Identifying Missing Genes in GeneSets    ############
#####    MS and NR Written July 19th 2022         ############
#############################################################

#Load Tissue Lists
#load("/Users/Admin/Desktop/R_course ISB Project/Code/HPA_Tissue_Lists/HPA_Tissues_10.1/Tissue_Elevated_Genes.RData")
load("/Users/Admin/Desktop/R_course ISB Project/Code/HPA_Tissue_Lists/HPA_Tissues_10.1/Tissue_Elevated_Genes.RData")

# Load Gene Lists of Interest

library(msigdbr)

##ake a separate Matrix for each Category
#Create a list for each different MSigDB Category
GeneSets = c("H","C2","C5","C6","C7")
for (x in GeneSets) {
  assign(x, msigdbr(species = "Homo sapiens", category = x))}

#For Each List, we need to go in and adll all the sub categories we will look at
KEGG<-C2[C2$gs_subcat=="CP:KEGG",]
GO_BP<-C5[C5$gs_subcat=="GO:BP",]
REACTOME<-C2[C2$gs_subcat=="CP:REACTOME",]
GO_CC<-C5[C5$gs_subcat=="GO:CC",]
BIOCARTA<-C2[C2$gs_subcat=="CP:BIOCARTA",]
GO_MF<-C5[C5$gs_subcat=="GO:MF",]

#names(GeneSets_Sublist)<-c("CP","CP:BIOCARTA","CP:KEGG","CP:REACTOME","BP","CC","MF")

#Startng with the first pathway

#expand it all the subsets we will look at
GeneSets = c("KEGG", "GO_BP", "REACTOME", "GO_CC", "BIOCARTA", "GO_MF")

Results_Elevated<-as.data.frame(matrix(nrow = length(names(Elevated_Genes)), ncol = 1+2*(length(GeneSets)))) #well need to increase this to 2+ Number of gene sets we want to loook at


colnames(Results_Elevated)<-c("N_Elevated",GeneSets,paste0("Percent_", GeneSets))

rownames(Results_Elevated)<-names(Elevated_Genes)

#First step: N Genes
for (i in 1:length(Elevated_Genes)) {
  Results_Elevated$N_Elevated[i]<-as.numeric(length(Elevated_Genes[[i]]))
}
#For Each Gene Set: Normal
for (i in 1:length(Elevated_Genes)) {
  Results_Elevated$GO_MF[i]<-as.numeric(length(intersect(GO_MF$human_gene_symbol, Elevated_Genes[[i]])))
}
Results_Elevated$Percent_GO_MF<-Results_Elevated$GO_MF/Results_Elevated$N_Elevated

#For Each Gene Set: Normal
for (i in 1:length(Elevated_Genes)) {
  Results_Elevated$GO_BP[i]<-as.numeric(length(intersect(GO_BP$human_gene_symbol, Elevated_Genes[[i]])))
}
Results_Elevated$Percent_GO_BP<-Results_Elevated$GO_BP/Results_Elevated$N_Elevated

for (i in 1:length(Elevated_Genes)) {
  Results_Elevated$GO_CC[i]<-as.numeric(length(intersect(GO_CC$human_gene_symbol, Elevated_Genes[[i]])))
}
Results_Elevated$Percent_GO_CC<-Results_Elevated$GO_CC/Results_Elevated$N_Elevated

for (i in 1:length(Elevated_Genes)) {
  Results_Elevated$KEGG[i]<-as.numeric(length(intersect(KEGG$human_gene_symbol, Elevated_Genes[[i]])))
}
Results_Elevated$Percent_KEGG<-Results_Elevated$KEGG/Results_Elevated$N_Elevated

for (i in 1:length(Elevated_Genes)) {
  Results_Elevated$BIOCARTA[i]<-as.numeric(length(intersect(BIOCARTA$human_gene_symbol, Elevated_Genes[[i]])))
}
Results_Elevated$Percent_BIOCARTA<-Results_Elevated$BIOCARTA/Results_Elevated$N_Elevated

for (i in 1:length(Elevated_Genes)) {
  Results_Elevated$REACTOME[i]<-as.numeric(length(intersect(REACTOME$human_gene_symbol, Elevated_Genes[[i]])))
}
Results_Elevated$Percent_REACTOME<-Results_Elevated$REACTOME/Results_Elevated$N_Elevated


#Next steps are to change up this code so it works for the other gene sets, and to do this for the Elevated genes as well

save(Results_Elevated, file="./HPA_Tissues_10.1/Results_Elevated_mastertable.RData")
write.csv(Results_Elevated, "./HPA_Tissues_10.1/Results_Elevated_mastertable.csv")