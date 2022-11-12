###################################################
############# Elevated Coverage Boxplot ###########
############ GH Edited for Lables 10/8 ############
###################################################

load("~/ISB/Coding/Results_Elevated_mastertable.RData")
as.data.frame(Results_Elevated)

KEGG <-Results_Elevated$Percent_KEGG
GO_BP <-Results_Elevated$Percent_GO_BP
REACTOME <-Results_Elevated$Percent_REACTOME
GO_CC <-Results_Elevated$Percent_GO_CC
BIOCARTA <-Results_Elevated$Percent_BIOCARTA
GO_MF <-Results_Elevated$Percent_GO_MF


#Make plot environment
par (mai=c(1,1.5,1,1)) #plot parameters

bp<-boxplot(GO_BP, GO_CC, REACTOME, KEGG, BIOCARTA, GO_MF,
        at = c(1,2,3,4,5,6),
        names = c("GO_BP", "GO_CC", "REACTOME", "KEGG", "BIOCARTA","GO_MF"),
        las = 1,
        col = c("light grey","light grey","light grey","light grey","light grey","light grey"),
        whiskcol = c("dark grey", "dark grey", "dark grey", "dark grey", "dark grey", "dark grey"),
        horizontal=TRUE,
        cex.axis=0.75,
        lty=1)

#label all points on boxplot
text(x=fivenum(GO_BP),labels=fivenum(GO_BP),y=1, adj=c(0.5, -0.5), srt=270, cex=0.6)
text(x=fivenum(GO_CC),labels=fivenum(GO_CC),y=2, adj=c(0.5, -0.5), srt=270, cex=0.6)
text(x=fivenum(REACTOME),labels=fivenum(REACTOME),y=3, adj=c(0.5, -0.5), srt=270, cex=0.6)
text(x=fivenum(KEGG),labels=fivenum(KEGG),y=4, adj=c(0.5, -0.5), srt=270, cex=0.6)
text(x=fivenum(BIOCARTA),labels=fivenum(BIOCARTA),y=5, adj=c(0.5, -0.5), srt=270, cex=0.6)
text(x=fivenum(GO_MF),labels=fivenum(GO_MF),y=6, adj=c(0.5, -0.5), srt=270, cex=0.6)


#Edit location, size, and content of titles
title(ylab="Gene Set Collection", line=5.25, cex.lab=1)
title(xlab="Percent Gene Coverage", line=2.5, cex.lab=1)
title(main="Percent Elevated Coverage by Gene Set Collection", line=1.5, cex.main=1)

#LABEL MEDIAN
#Round all percent gene set collections to 2 digits
#e <- round(as.numeric(GO_BP),digits=2)
#f <- round(as.numeric(GO_CC),digits=2)
#g <- round(as.numeric(REACTOME),digits=2)
#h <- round(as.numeric(KEGG),digits=2)
#i <- round(as.numeric(BIOCARTA),digits=2)
#j <- round(as.numeric(GO_MF),digits=2)


#Label median on all boxplots
#text(x=median(e), labels =median(e), y=1, adj=c(0.5, -0.5), srt=270, cex=0.75)
#text(x=median(f), labels =median(f), y=2, adj=c(0.5, -0.5), srt=270, cex=0.75)
#text(x=median(g), labels =median(g), y=3, adj=c(0.5, -0.5), srt=270, cex=0.75)
#text(x=median(h), labels =median(h), y=4, adj=c(0.5, -0.5), srt=270, cex=0.75)
#text(x=median(i), labels =median(i), y=5, adj=c(0.5, -0.5), srt=270, cex=0.75)
#text(x=median(j), labels =median(j), y=6, adj=c(0.5, -0.5), srt=270, cex=0.75)



#Save plot as pdf with 5 x 9 in size for perfect figure size
