###################################################
############# Elevated Coverage Boxplot ###########
####### GH Edited for Entrez & Cut Off 12/3 #######
###################################################
filename<-load("~/ISB/Figures/Results_Elevated_mastertable.RData")

N_Genes <-Results_Elevated$N_Elevated

###########KEGG Bar Plot

par (mai=c(1.5,1,0.5,0.5))
#sort Results_Elevated by number of genes per tissue in decreasing order and label new vector
ng2 <- Results_Elevated[order(Results_Elevated$N_Elevated,decreasing = TRUE),]
#remove bars with too-small # of genes
#ng <- ng2[-c(18:36),] for Enriched
#ng <- ng2[-c(20:36),] for Elevated
ng <- ng2[-c(20:36),]

#plot new vector
bpNGElevated <-barplot(ng$N_Elevated, names = rownames(ng), las=2,ylim=c(0,1000), 
                 cex.names = 0.75, cex.axis = 0.75)
#ylim=c(0,1000) for Enriched
#ylim=c(0,3000) for Elevated

#Edit location, size, and content of titles
title(ylab="Number of Genes", line=3, cex.lab=0.75)
title(xlab="Tissue", line=5, cex.lab=0.75)
title(main="Number of Elevated Genes per Tissue", line=0, cex.main=1)

#Median number of genes
median(Results_Elevated$N_Elevated)

