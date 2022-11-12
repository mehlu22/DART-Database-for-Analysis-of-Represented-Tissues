#############################################################
#####  Code to Import .CSV Files & Turn into List############
#####  AGP & GH Written March 7th 2018            ############
##############################################################

##Load list of all genes
load("/Users/Admin/Desktop/R_course ISB Project/Code/HPA_Tissue_Lists/HPA_Tissues_10.1/AllGenes.RData")

#First, call upon the directory where this stuff is stored
directory<-"/Users/Admin/Desktop/R_course ISB Project/Code/HPA_Tissue_Lists/HPA_Tissues_10.1/"
#### Enhanced Genes #####


#Load the filenames in this directory that are titled Enhanced
Enriched <- grep("Enriched", list.files(directory),value=T)

#Load all of these files into a list:
Enriched_Genes<-list()
for (i in 1:length(Enriched)){
  tmp = read.csv(file = paste0(directory,"/",Enriched[i]), sep="\t",header=T) #this loads it. NOTE: Is very messy since theres no good way to parse the data here. thats fine since we only want the first rowname
  Enriched_Genes[[i]]<-as.character(tmp[,1])# only load the first column. take away the first row as it is the title: "Gene"
}
#get a list of all the actual tissues we loaded
Enriched_Names<-gsub(x = Enriched, pattern = paste(c("HPA_","_Enriched",".Rdata"), collapse = "|"), replacement = "", ignore.case = TRUE)

#name our list with this
names(Enriched_Genes)<-Enriched_Names



#save this
save(Enriched_Genes,file="./HPA_Tissues_10.1/Tissue_Enriched_Genes.RData")
write.csv(Enriched_Genes, "./HPA_Tissues_10.1/Tissue_Enriched_Genes.csv")
#Step 2: Modify this code & do the same to make a list for elevated


#Load the filenames in this directory that are titled Enhanced
Elevated <- grep("Elevated", list.files(directory),value=T)

#Load all of these files into a list:
Elevated_Genes<-list()
for (i in 1:length(Elevated)){
  tmp = read.csv(file = paste0(directory,"/",Elevated[i]), sep="\t",header=T) #this loads it. NOTE: Is very messy since theres no good way to parse the data here. thats fine since we only want the first rowname
  Elevated_Genes[[i]]<-as.character(tmp[,1])# only load the first column. take away the first row as it is the title: "Gene"

}
#get a list of all the actual tissues we loaded
Elevated_Names<-gsub(x = Elevated, pattern = paste(c("HPA_","_Elevated",".Rdata"), collapse = "|"), replacement = "", ignore.case = TRUE)

#name our list with this
names(Elevated_Genes)<-Elevated_Names



#save this
save(Elevated_Genes,file="./HPA_Tissues_10.1/Tissue_Elevated_Genes.RData")
write.csv(Elevated_Genes, "./HPA_Tissues_10.1/Tissue_Elevated_Genes.csv")