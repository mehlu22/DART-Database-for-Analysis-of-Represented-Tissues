#############################################################
#####   Identifying Missing Genes in GeneSets    ############
################    MS Revised July 20th, 2022        ##############
#############################################################

#Load Tissue Lists
load("~/ISB/Figures/Tissue_Enriched_Genes.RData")

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
GeneSets = c("GO_BP", "GO_MF", "GO_CC", "REACTOME", "KEGG", "BIOCARTA")

Results_Enriched2<-as.data.frame(matrix(nrow = length(names(Enriched_Genes)), ncol = 1+2*(length(GeneSets)))) #well need to increase this to 2+ Number of gene sets we want to loook at


colnames(Results_Enriched2)<-c("N_Enriched",GeneSets,paste0("Percent_", GeneSets))

rownames(Results_Enriched2)<-names(Enriched_Genes)


#First step: N Genes
for (i in 1:length(Enriched_Genes)) {
  Results_Enriched2$N_Enriched[i]<-as.numeric(length(Enriched_Genes[[i]]))
}
#For Each Gene Set: Normal
for (i in 1:length(Enriched_Genes)) {
  Results_Enriched2$BIOCARTA[i]<-as.numeric(length(intersect(BIOCARTA$entrez_gene, Enriched_Genes[[i]])))
}
Results_Enriched2$Percent_BIOCARTA<-round(Results_Enriched2$BIOCARTA/Results_Enriched2$N_Enriched,digits=3)


#Next steps are to change up this code so it works for the other gene sets, and to do this for the Enriched genes as well

Results_Enriched <- Results_Enriched2

save(Results_Enriched, file="~/ISB/Figures/Results_Enriched_mastertable.RData")
write.csv(Results_Enriched, "~/ISB/Figures/Results_Enriched_mastertable.csv")
