############### 2. Converting HGNC_IDs to Entrez
########## Edited by GH for HPA/MSigDB 11/12/19 ###########
###########################################################

##Install org.Hs.eg.db for R version 3.6
##http://bioconductor.org/packages/release/data/annotation/html/org.Hs.eg.db.html
#if (!requireNamespace("BiocManager", quietly = TRUE))
  #install.packages("BiocManager")
#BiocManager::install("org.Hs.eg.db")
library('org.Hs.eg.db') ##mapping within EntrezGene


##Install biomaRt (Ensembl) for R version 3.6                        ###Do I need this??
##http://bioconductor.org/packages/release/bioc/html/biomaRt.html
#if (!requireNamespace("BiocManager", quietly = TRUE))
  #install.packages("BiocManager")
#BiocManager::install("biomaRt")
library(biomaRt) ##Retrieve biomaRt

mart <- useEnsembl("ensembl","hsapiens_gene_ensembl", mirror = "uswest") ##biomaRt code to use ensemble

#This is a function that I wrote
Gene2Entrez<-function(Genelist,mart){ ##Create a function with arguments Genelist and mart 
  annotmp <- getBM(c("hgnc_symbol","entrezgene_id"), "hgnc_symbol", Genelist, mart) 
  ##temp; getBM for vector c(), "hgnc_symbol", Genelist, mart
  ##here, change hgnc_symbol to whatever I have
  
  genes<-as.character(annotmp$entrezgene_id) 
  ##make a character list of entrezgene_id called genes
  
  genes
}



## 1. Convert HPA HGNC to Entrez
##Do for every tissue, Elevated and Enriched
filename <- (read.table(file = '~/ISB/HPA_Tissues_10.1/HPA_SalivaryGland_Enriched.tsv', sep = '\t', header = TRUE))
tissue <- as.character(filename$Gene)
SalivaryGland_Enriched_Genes2<-Gene2Entrez(tissue,mart)
#table(is.na(SalivaryGland_Enriched_Genes2)) ##use to see if NA present
SalivaryGland_Enriched_Genes<-na.omit(SalivaryGland_Enriched_Genes2) #get rid of na
#table(is.na(SalivaryGland_Enriched_Genes)) ##test to see if NA still present

##Save Entrez character list
save(SalivaryGland_Enriched_Genes,file="~/ISB/HPA_Tissues_Entrez_11.12/SalivaryGland_Enriched_Genes.Rdata")


## 2. Convert MSigDB ___ to Entrez
##replace $human_gene_symbol with $entrez_gene






