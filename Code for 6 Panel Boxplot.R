###################################################
############# Elevated Coverage Boxplot ###########
############### GH Edited for MF 11/6 #############
###################################################
filename<-load("~/ISB/Newest Coding/Results_Elevated_mastertable.RData")

KEGG <-Results_Elevated$Percent_KEGG
GO_BP <-Results_Elevated$Percent_GO_BP
REACTOME <-Results_Elevated$Percent_REACTOME
GO_CC <-Results_Elevated$Percent_GO_CC
BIOCARTA <-Results_Elevated$Percent_BIOCARTA
GO_MF <-Results_Elevated$Percent_GO_MF

###########KEGG Bar Plot

par (mai=c(1.5,1,0.5,0.5))
#sort Results_Elevated by Percent_KEGG in decreasing order and label new vector
df <- Results_Elevated[order(Results_Elevated$Percent_KEGG,decreasing = TRUE),]
#plot new vector
bpKEGG <-barplot(df$Percent_KEGG, names = rownames(df), las=2,ylim=c(0,1), 
                 cex.names = 0.6, cex.axis = 0.75, col=2)

#Edit location, size, and content of titles
title(ylab="Percent Gene Coverage", line=3, cex.lab=0.75)
title(xlab="Tissue", line=4.2, cex.lab=0.75)
title(main="Percent Elevated Coverage by KEGG", line=0, cex.main=1)


#############GO_BP Bar Plot
df2 <- Results_Elevated[order(Results_Elevated$Percent_GO_BP,decreasing = TRUE),]
bpGO_BP <-barplot(df2$Percent_GO_BP, names = rownames(df2), las=2, ylim=c(0,1),
                  cex.names = 0.6, cex.axis = 0.75,col=3)

#Edit location, size, and content of titles
title(ylab="Percent Gene Coverage", line=3, cex.lab=0.75)
title(xlab="Tissue", line=4.2, cex.lab=0.75)
title(main="Percent Elevated Coverage by GO_BP", line=0.5, cex.main=1)


############REACTOME Bar Plot
df3 <- Results_Elevated[order(Results_Elevated$Percent_REACTOME,decreasing = TRUE),]
bpREACTOME <-barplot(df3$Percent_REACTOME, names = rownames(df3), las=2, ylim=c(0,1),
                     cex.names = 0.6, cex.axis = 0.75, col=4)

#Edit location, size, and content of titles
title(ylab="Percent Gene Coverage", line=3, cex.lab=0.75)
title(xlab="Tissue", line=5, cex.lab=0.75)
title(main="Percent Elevated Coverage by REACTOME", line=0.5, cex.main=1)


##############GO_CC Bar Plot
df4 <- Results_Elevated[order(Results_Elevated$Percent_GO_CC,decreasing = TRUE),]
bpGO_CC <-barplot(df4$Percent_GO_CC, names = rownames(df4), las=2, ylim=c(0,1),
                  cex.names = 0.6, cex.axis = 0.75,col=5)

#Edit location, size, and content of titles
title(ylab="Percent Gene Coverage", line=3, cex.lab=0.75)
title(xlab="Tissue", line=4.7, cex.lab=0.75)
title(main="Percent Elevated Coverage by GO_CC", line=0.5, cex.main=1)


##############BIOCARTA Bar Plot
df5 <- Results_Elevated[order(Results_Elevated$Percent_BIOCARTA,decreasing = TRUE),]
bpBIOCARTA <-barplot(df5$Percent_BIOCARTA, names = rownames(df5), las=2, ylim=c(0,1),
                     cex.names = 0.6, cex.axis = 0.75,col=6)

#Edit location, size, and content of titles
title(ylab="Percent Gene Coverage", line=3, cex.lab=0.75)
title(xlab="Tissue", line=4.7, cex.lab=0.75)
title(main="Percent Elevated Coverage by BIOCARTA", line=0.5, cex.main=1)




##############GO_MF Bar Plot
df6 <- Results_Elevated[order(Results_Elevated$Percent_GO_MF,decreasing = TRUE),]
bpGO_MF <-barplot(df6$Percent_GO_MF, names = rownames(df6), las=2, ylim=c(0,1),
                  cex.names = 0.6, cex.axis = 0.75,col=7)

#Edit location, size, and content of titles
title(ylab="Percent Gene Coverage", line=3, cex.lab=0.75)
title(xlab="Tissue", line=4.7, cex.lab=0.75)
title(main="Percent Elevated Coverage by GO_MF", line=0.5, cex.main=1)












#Final 6-panel
#Did not use because can't figure out how to show titles
#par(mfrow=c(3,2))
#bpKEGG <-barplot(df$Percent_KEGG, names = rownames(df), las=2, cex.names = 0.6, cex.axis = 0.75)
#title(ylab="Percent Gene Coverage", line=3, cex.lab=0.75)
#title(xlab="Tissue", line=5.2, cex.lab=0.75)
#title(main="Percent Elevated Coverage by KEGG", line=1.5, cex.main=1)
#bpGO_BP <-barplot(df2$Percent_GO_BP, names = rownames(df2), las=2, cex.names = 0.6, cex.axis = 0.75)
#bpREACTOME <-barplot(df3$Percent_REACTOME, names = rownames(df3), las=2, cex.names = 0.6, cex.axis = 0.75)
#bpGO_CC <-barplot(df4$Percent_GO_CC, names = rownames(df4), las=2, cex.names = 0.6, cex.axis = 0.75)
#bpBIOCARTA <-barplot(df5$Percent_BIOCARTA, names = rownames(df5), las=2, cex.names = 0.6, cex.axis = 0.75)
#bpGO_MF <-barplot(df6$Percent_GO_MF, names = rownames(df6), las=2, cex.names = 0.6, cex.axis = 0.75)

