# This is an R script designed to do the R and Bioconductor assignment
# Question 1
sample_metadata <- read.csv("diabimmune_16s_t1d_metadata.csv", header = T)
head(sample_metadata)
library(phyloseq)
library(biomformat)
# skja <- read_biom("diabimmune_t1d_16s_otu_table.txt")
# skrl <- import_biom("diabimmune_t1d_16s_otu_table.txt")
# sal <- read.table("diabimmune_t1d_16s_otu_table.txt", header = T)
# head(sal)

# biom_file <- system.file("extdata", "rich_sparse_otu_table.biom", package = "biomformat")
# biom_file
# x <- read_biom(biom_file)
# header(x)

otut <- read.table("otu_table")
head(otut, n = 1)

taxat <- read.table("new_taxa_table")
head(taxat)
dim(taxat)
dim(otut)
class(taxat)
class(otut)
otut_mat <- as.matrix(otut)
class(otut_mat)
taxat_mat <- as.matrix(taxat)
class(taxat_mat)
head(taxat_mat)
taxat_mat_sub <- gsub(";", "", taxat_mat)
head(taxat_mat_sub)
mat_names <- row.names(taxat_mat_sub)
new_naam <- gsub(";", "", mat_names)
new_naam
row.names(taxat_mat_sub) <- new_naam
library("phyloseq")
OTU <- otu_table(otut_mat, taxa_are_rows = TRUE)
TAX <- tax_table(taxat_mat_sub)
OTU
TAX

physeq <- phyloseq(OTU, TAX)
physeq
