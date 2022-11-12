############# Code for Heatmaps ##############
########## Entrez Updated 01.02.20 ###########
##################### GH #####################

install.packages("pheatmap")
library(pheatmap)

load("~/ISB/Figures/Results_Elevated_mastertable.RData") #######load dataset
RE<-Results_Elevated[,-c(1:7)]
colnames(RE) = c("GO_BP", "GO_MF", "GO_CC", "REACTOME", "KEGG", "BIOCARTA")

myCol <- (c("white","white","yellow","orange","red1","red3")) ######red is highest coverage
pheatmap(RE, display_numbers = TRUE,
         col=myCol,
         cluster_rows = F,
         cluster_cols = F,
         cellwidth=35, #Change tehe for size
         cellheight=9,
         fontsize_number = 8,
         cex=0.9)

