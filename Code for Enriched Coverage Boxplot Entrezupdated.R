###################################################
############# Enriched Coverage Boxplot ###########
########## GH Edited for Entrez 1/7/20 ############
###################################################

load("~/ISB/Figures/Results_Enriched_mastertable.RData")
##this is converting to Entrez because new mastertable made from Entrez
as.data.frame(Results_Enriched)

KEGG <-Results_Enriched$Percent_KEGG
GO_BP <-Results_Enriched$Percent_GO_BP
REACTOME <-Results_Enriched$Percent_REACTOME
GO_CC <-Results_Enriched$Percent_GO_CC
BIOCARTA <-Results_Enriched$Percent_BIOCARTA
GO_MF <-Results_Enriched$Percent_GO_MF


#Make plot environment
par (mai=c(1,1.5,1,1)) #plot parameters

#Make boxplot
x<-list("GO_BP"=GO_BP, "GO_MF"=GO_MF, "GO_CC"=GO_CC, 
        "REACTOME"=REACTOME,"KEGG"=KEGG, "BIOCARTA"=BIOCARTA)

bp<-boxplot(x,
            las = 1, outline=FALSE,
            whiskcol = c("dark grey", "dark grey", "dark grey", "dark grey", "dark grey", "dark grey"),
            horizontal=TRUE,
            cex.axis=0.75,
            lty=1)

#Make stripchart and add boxplot
#COLOR option
bp2<-stripchart(x,
                col=brewer.pal(n = 6, name = "Set2"),pch=16, ##pch gives shape of point
                method="jitter",cex=0.75,
                cex.axis=0.75,las=2, ##method specifies the way coincident points are plotted
                add=TRUE) ##combines boxpot with stripchart
#B&W option
#bp2<-stripchart(x,
#col=c("Black"),pch=16, ##pch gives shape of point
#method="jitter",cex=0.75,
#cex.axis=0.75,las=2, ##method specifies the way coincident points are plotted
#add=TRUE) ##combines boxpot with stripchart

#LABELS option
#label all points on boxplot
text(x=fivenum(GO_BP),labels=fivenum(GO_BP),y=1, adj=c(0.5, -0.5), srt=270, cex=0.6)
text(x=fivenum(GO_MF),labels=fivenum(GO_MF),y=2, adj=c(0.5, -0.5), srt=270, cex=0.6)
text(x=fivenum(GO_CC),labels=fivenum(GO_CC),y=3, adj=c(0.5, -0.5), srt=270, cex=0.6)
text(x=fivenum(REACTOME),labels=fivenum(REACTOME),y=4, adj=c(0.5, -0.5), srt=270, cex=0.6)
text(x=fivenum(KEGG),labels=fivenum(KEGG),y=5, adj=c(0.5, -0.5), srt=270, cex=0.6)
text(x=fivenum(BIOCARTA),labels=fivenum(BIOCARTA),y=6, adj=c(0.5, -0.5), srt=270, cex=0.6)


#Edit location, size, and content of titles
title(ylab="Gene Set Collection", line=5.25, cex.lab=1)
title(xlab="Fraction Gene Coverage", line=2.5, cex.lab=1)
title(main="Fraction Enriched Coverage by Gene Set Collection", line=1.5, cex.main=1)


#Save plot as pdf with 5 x 9 in size for perfect figure size


