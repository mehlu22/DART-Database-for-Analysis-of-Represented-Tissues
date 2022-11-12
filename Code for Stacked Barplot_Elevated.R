###################################################
################## Stacked Barplot ################
################## GH Made 1/9/20 #################
###################################################
filename<-load("~/ISB/Figures/Results_Elevated_mastertable.RData")
library(RColorBrewer)

KEGG <-Results_Elevated$Percent_KEGG
GO_BP <-Results_Elevated$Percent_GO_BP
REACTOME <-Results_Elevated$Percent_REACTOME
GO_CC <-Results_Elevated$Percent_GO_CC
BIOCARTA <-Results_Elevated$Percent_BIOCARTA
GO_MF <-Results_Elevated$Percent_GO_MF


GSC<-c("GO_BP","GO_MF","GO_CC","REACTOME","KEGG","BIOCARTA")
Color<-as.character(c(palette(rainbow(6)))) ##placeholder for colors


##Trim down mastertable to get data frame we want
MT<-(as.matrix(Results_Elevated[,-c(1:7)]))
MT2<-t(MT)

##Rearrange MT to look like Times so that we can merge
MT3<-cbind(GSC = GSC, MT2) ##convert the rownames to a proper column of the matrix and call it GSC


##create a vector with specific colors
Times<-as.data.frame(cbind(GSC,as.character(Color)))
colnames(Times)<-c("GSC","Color")

#merge the datasets and call it "Bar"
Bar<-merge(MT3,Times,decreasing=TRUE,by="GSC",all=F)
Bar2<-Bar[c(2,4,3,6,5,1),] ##rearrange data.frame by descending

##Make another matrix (Bar2) without columns GSC and Color
Bar3<-(as.matrix(Bar2[,-c(1,38)]))


Color<-as.character(Bar$Color)
par (mai=c(2,1,1,1)) #plot parameters
##make a barplot of Bar2 data frame with different colors
##### each color represents a GroupID (row), size of color represents how many genes there are
bp<-barplot(Bar3,col=brewer.pal(n = 6, name = "Set2"), ##replace rainbow w/preset palette
            space=0,border="black",ylim=c(0,6),
            las=2,cex.names=0.8) ###,beside=T

legend("topright", GSC, col=brewer.pal(n=6,name="Set2"),cex=0.75, pch=7, pt.cex = 1,pt.lwd = 3)

##Label the stacked barplot
title(ylab="Fraction Gene Coverage", line=2.5, cex.lab=1)
title(xlab="Tissue", line=7, cex.lab=1)
title(main="Fraction Coverage per Elevated Tissue", line=0, cex.main=1)

