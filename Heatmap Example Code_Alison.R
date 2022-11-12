############### 1. Improved Heatmaps with R

install.packages("pheatmap")
library(pheatmap)
# Note: Sigpathways is a matrix (4 x 21 with integers of P values (0-1)), so similar to yours

SigPathways<-round(SigPathways,2) #rounding to make it look prettier

# You can play around with this, i had cutoffs where >0.25 basically doesnt show up
myCol <- (c("red4","red1","orangered","yellow","white","white"))
myBreaks <- c(0,0.01,0.05,0.1,0.25,1)

#This is to change the text color in the heatmap, you may not need to do this
X<-as.vector(Results_Elevated)
X<-as.character(X<0.26)
X<-recode(X,"TRUE='black';FALSE='white'")

pheatmap(Results_Elevated, display_numbers = T,
         col=myCol,
         breaks=myBreaks,
         cluster_rows = F,
         cluster_cols = F,
         cellwidth=35, #Change tehe for size
         cellheight=25, #change these for size
         number_color = X,
         fontsize_number = 15)
