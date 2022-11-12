############### 3. Boxplots with Points Included
colors<-c("darkmagenta","forestgreen")
i=12

par(mfrow=c(4,3),mar=c(2,2,2,2))
for (i in 1:12){
  
  boxplot(miRNA2[,i]~miRNA2$PretermGroup,vertical=T,
          col="white", medcol=colors, whiskcol=colors, staplecol=colors, boxcol=colors, outcol=colors,
          pch=16,cex=1.4,ylim=c(0,20),boxwex=0.9,
          ylab="log RPKM",method="jitter",main=colnames(miRNA2)[i])
  
  stripchart(miRNA2[,i]~miRNA2$PretermGroup,vertical=T,
             col=c("darkmagenta","forestgreen"),pch=16,cex=1.4,
             ylim=c(4,22),add=T,,method="jitter")
}