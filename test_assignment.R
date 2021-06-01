# This is an R script designed to do the R and Bioconductor assignment
# Question 1
sample_metadata <- read.csv("diabimmune_16s_t1d_metadata.csv", header = T) # read the sample data
head(sample_metadata)
library(phyloseq)
library(biomformat)

otut <- read.table("otu_table") # import otu table
head(otut, n = 1)

taxat <- read.table("new_taxa_table") # import taxa table
head(taxat)
dim(taxat)
dim(otut)
class(taxat)
class(otut)
otut_mat <- as.matrix(otut) # convert the otu table into a matrix
class(otut_mat)
taxat_mat <- as.matrix(taxat) # convert the taxa table into a matrix
class(taxat_mat)
head(taxat_mat)
taxat_mat_sub <- gsub(";", "", taxat_mat) # remove ; from the columns of taxa table
head(taxat_mat_sub)

# Our row names are ending with ; and this makes them different from the naming in the otu table
# so we need to remove the ;
mat_names <- row.names(taxat_mat_sub) # extract the rownames and store them in the mat_names object
new_naam <- gsub(";", "", mat_names) # remove ; from the mat_names and store them to new_naam
new_naam
row.names(taxat_mat_sub) <- new_naam # now change the row names of taxat_mat_sub to the names in "new_naam

OTU <- otu_table(otut_mat, taxa_are_rows = TRUE)
TAX <- tax_table(taxat_mat_sub)
OTU
TAX

physeq <- phyloseq(OTU, TAX)
physeq

# Question 1 --------------------------------------------------------------


## Question1
# Import the data described above into R, \
# provide descriptive summaries of the subject data \
# (using appropriate graphics and statistical summary measures) \
# given in the diabimmune_16s_t1d_metadata.csv file. \
# In addition, use appropriate test(s) to check for association/independency \
# between disease status and other variables (delivery mode, gender and age). \
# Note that age is given in days.
sample_metadata <- read.csv("diabimmune_16s_t1d_metadata.csv", header = T) # read the sample data
# Explore the data and check for any missing info
head(sample_metadata)
tail(sample_metadata)
dim(sample_metadata)
startsWith(sample_metadata$Sample_ID, "G")
chec_sample <- grepl('^G[0-9]+$', sample_metadata$Sample_ID) # makesure all sample ids start with G and end with a digit
table(chec_sample)
chec_subject <- grepl('^E[0-9]+$', sample_metadata$Subject_ID)
table(chec_subject)
head(sample_metadata)


# descriptive statistics
library(tidyverse)

# How many were cases and controls ----------------------------------------

# head(sample_metadata)
# summary(sample_metadata)
sample_metadata %>% 
  group_by(Case_Control) %>% 
  summarise(Total = n(), Percentage = (Total / 777) * 100)


# How many were males and females -----------------------------------------

sample_metadata %>% 
  group_by(Gender) %>% 
  summarise(Total = n(), Percentage = (Total / 777) * 100)
head(sample_metadata)

# How many fall into each delivery route ----------------------------------
nrow(sample_metadata)
sample_metadata %>% 
  group_by(Delivery_Route) %>% 
  summarise(Total = n(), Percentage = (Total / nrow(sample_metadata)) * 100)
head(sample_metadata)

# Descriptive statistics with the age -------------------------------------

## Calculate the mean age (Note that the age is in days)
summary(sample_metadata$Age_at_Collection)

## Caculate the standard deviation
sd(sample_metadata$Age_at_Collection)

# Cases and controls versus gender ----------------------------------------

sample_metadata %>% 
  group_by(Gender, Case_Control) %>% 
  summarise(Total = n(), Percentage = (Total / nrow(sample_metadata)) * 100)

# Cases and controls versus delivery route --------------------------------

sample_metadata %>% 
  group_by(Case_Control, Delivery_Route) %>% 
  summarise(Total = n(), Percentage = (Total / nrow(sample_metadata)) * 100)

# Cases and controls, gender and delivery route ---------------------------

sample_metadata %>% 
  group_by(Gender, Case_Control, Delivery_Route) %>% 
  summarise(Total = n(), Percentage = (Total / nrow(sample_metadata)) * 100)
