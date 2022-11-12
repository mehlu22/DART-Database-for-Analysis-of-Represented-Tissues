############### Code for Stacked Boxplot_Univeriate ##########
######################## Written by AP #######################
################# Annotated by GH on 1/7/20 ##################


## character list called GroupID
GroupID<-c("gd7","gd10","gd10_gd15","gd7_gd10_gd15","gd10_gd15_gd19",
           "gd10_gd19","gd15","gd15_gd19","gd19","gd7_gd10_gd15_gd19",
           "gd7_gd15","gd7_gd15_gd19","gd7_gd19")

##create a vector with specific colors
Color<-as.character(c(palette(rainbow(9)),c("dimgray","cornsilk1","darkseagreen1","khaki4")))

##Make a pie chart of those colors
pie(rep(1,13), col=Color)

##Take GroupID vector and combine as first column
##Take Color vector and combine as second column
##Turn it into a data frame and call it "Times"
Times<-as.data.frame(cbind(GroupID,as.character(Color)))
colnames(Times)<-c("GroupID","Color") ##name the columns
x2<-as.character(Times$Color) ##extract the Color column from the data frame and call it x2
pie(rep(1,13), col=x2) ##make a pie chart of the colors from the data frame (this is the same as line 11)


##upload dataset
KidneyBar<-read.csv("~/ISB/Codes/Code for Stacked Boxplot_EXcode_KidneyBarplot.csv")
#merge the datasets and call it "Bar"
Bar<-merge(KidneyBar,Times,by="GroupID",all=F)


#levels(Bar$GroupID)<-c("gd7","gd10","gd10_gd15","gd7_gd10_gd15","gd10_gd15_gd19","gd10_gd19","gd15","gd15_gd19","gd19","gd7_gd10_gd15_gd19","gd7_gd15","gd7_gd15_gd19","gd7_gd19")
rownames(Bar)<-Bar$GroupID

levels(Bar$GroupID)

##Figure out which column to sort Bar by
#Bar<-Bar[order(Bar$gd7,decreasing = F),]
#Bar<-Bar[order(Bar$gd10),]

Bar<-Bar[order(Bar$gd15,decreasing = T),]
Bar<-Bar[order(Bar$gd19,decreasing = T),]

##Make another matrix (Bar2) without columns GroupID and Color
Bar2<-(as.matrix(Bar[,-c(1,6)]))



Color<-as.character(Bar$Color)
par(lwd = 1.75) #plot parameters
##make a barplot of Bar2 data frame with different colors
##### each color represents a GroupID (row), size of color represents how many genes there are
barplot(Bar2,col=Color,space=0.1,border="black",ylim=c(0,340))#,beside=T)

Total<-colSums(Bar2) ##Find the total number of genes in each bar (individual gd group)

##Edit the location of the labels, print the total genes above each bar
text(x=c(0.625,1.625,2.75,3.8),y=Total+10,print(Total),cex=1.25)
#4x5


#text(x=c(0.75,2,3.25,4.5),y=Total+15,print(Total),cex=1)
