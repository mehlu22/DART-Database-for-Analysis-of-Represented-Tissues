############# Code for Heatmaps ##############
########## Entrez Updated 01.02.20 ###########
##################### GH #####################

install.packages("pheatmap")
library(pheatmap)

load("~/ISB/Figures/Results_Elevated_mastertable.RData") #######load dataset
RE3<-Results_Elevated[,-c(2:7)] #####cut off numbers of genes/collection columns
RE2 <- RE3[order(RE3$N_Elevated,decreasing = TRUE),] ####reorder table decreasing
RE <-RE2[-c(20:37),-c(1)] ######cut off N_genes first column and use tissue cut-off
########Elevated:-c(20:37)
########Enriched:-c(18:37)
colnames(RE) = c("GO_BP", "GO_MF", "GO_CC", "REACTOME", "KEGG", "BIOCARTA")


myCol <- (c("white","white","yellow","orange","red1","red3")) ######red is highest coverage
pheatmap(RE, display_numbers = TRUE,
         col=myCol,
         cluster_rows = F,
         cluster_cols = F,
         cellwidth=90, #Change tehe for size
         cellheight=40,
         fontsize_number = 15,
         cex=1.5,
         number_color="black")

