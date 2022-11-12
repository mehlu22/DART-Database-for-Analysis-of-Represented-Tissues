#######################################################
###  Code for Tissue__Genes by Converting to Entrez ###
#######  Adapted by GH 11/26/2019 for Entrez IDs ######
#######################################################

#First, call upon the directory where this stuff is stored
directory<-"~/ISB/HPA_Tissues_10.1/"

library('org.Hs.eg.db')
library(biomaRt) ##Retrieve biomaRt
###biomart function
mart <- useEnsembl("ensembl","hsapiens_gene_ensembl", mirror = "uswest") ##biomaRt code to use ensemble

###convert HGNC to Entrez function
Gene2Entrez<-function(Genelist,mart){ ##Create a function with arguments Genelist and mart 
  annotmp <- getBM(c("hgnc_symbol","entrezgene_id"), "hgnc_symbol", Genelist, mart) 
  ##temp; getBM for vector c(), "hgnc_symbol", Genelist, mart
  ##here, change hgnc_symbol to whatever I have
  
  genes<-as.character(annotmp$entrezgene_id) 
  ##make a character list of entrezgene_id called genes
  
  genes
}


#Load the filenames in this directory that are titled Elevated
Elevated <- grep("Elevated", list.files(directory),value=T)


#Load all of these files into a list:
Elevated_Genes<-list()
for (i in 1:length(Elevated)){
  tmp = read.csv(file = paste0(directory,"/",Elevated[i]), sep="\t",header=T)
    #load original HGNC file and call it tmp
  tmp<-as.character(tmp[,1])
    #extract the first column of the HGNC file as a character
  tmp2<-Gene2Entrez(tmp,mart)
    #convert HGNC to Entrez and call the new string "tmp2"
  tmp3<-na.omit(tmp2)
  Elevated_Genes[[i]]<-as.character(tmp3)
    #for every index 1-34, fill row with character list tmp2
  #table(is.na(Elevated_Genes2)) ##use to see if NA present
  #Elevated_Genes<-na.omit(Elevated_Genes2) #get rid of NA
  
}

#get a list of the names of tissues we loaded
Elevated_Names<-gsub(x = Elevated, pattern = paste(c("HPA_","_Elevated",".tsv"), 
                                collapse = "|"), replacement = "", ignore.case = TRUE)
#name our list with this
names(Elevated_Genes)<-Elevated_Names
  
  
  
#save to Dropbox
save(Elevated_Genes,file="~/ISB/Figures/Tissue_Elevated_Genes.RData")

#Step 2: Modify this code & do the same to make a list for Elevated
  
  