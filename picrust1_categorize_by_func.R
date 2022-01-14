### Modified by JM to accept any category level
# github: jomaldon
### Original from https://github.com/picrust/picrust2/wiki/Frequently-Asked-Questions#how-can-i-run-categorize_by_functionpy-like-in-picrust1

### Reproducing the categorize by function (level 3) functionality in plain-text tables.
### Doing this because adding a column of KEGG Pathways to a table and then converting
### that table to BIOM is difficult.

categorize_by_function <- function(in_ko, kegg_brite_mapping,level) {
  # Function to create identical output as categorize_by_function.py script,
  # but with R objects instead of BIOM objects in Python.
  # Input KO table is assumed to have rownames as KOs and sample names as columns.

  out_pathway <- data.frame(matrix(NA, nrow=0, ncol=(ncol(in_ko) + 1)))

  colnames(out_pathway) <- c("pathway", colnames(in_ko))

  for(ko in rownames(in_ko)) {
    
    # Skip KO if not in KEGG BRITE mapping df
    # (this occurs with newer KOs that weren't present in PICRUSt1).
    if(! ko %in% rownames(kegg_brite_mapping)) {
      next
    }
    
    pathway_list <- strsplit(kegg_brite_mapping[ko, "metadata_KEGG_Pathways"], "\\|")[[1]]
    
    for(pathway in pathway_list) {
      
      pathway <- strsplit(pathway, ";")[[1]][level] # nivel
      
      new_row <- data.frame(matrix(c(NA, as.numeric(in_ko[ko,])), nrow=1, ncol=ncol(out_pathway)))
      colnames(new_row) <- colnames(out_pathway)
      new_row$pathway <- pathway
      out_pathway <- rbind(out_pathway, new_row)
    }
    
  }
  
  out_pathway = data.frame(aggregate(. ~ pathway, data = out_pathway, FUN=sum))
  
  rownames(out_pathway) <- out_pathway$pathway
  
  out_pathway <- out_pathway[, -which(colnames(out_pathway) == "pathway")]
  
  if(length(which(rowSums(out_pathway) == 0)) > 0) {
    out_pathway <- out_pathway[-which(rowSums(out_pathway) == 0), ]
  }
  
  return(out_pathway)
  
}


### Example commands:
### Read in BRITE hierarchy per KO.
 kegg_brite_map <- read.table("picrust1_KO_BRITE_map.tsv",
                              header=TRUE, sep="\t", quote = "", stringsAsFactors = FALSE, comment.char="", row.names=1)
#
# 
### When reading in tab-delimited file of KO predictions (PICRUSt2 output):
 table_ko <- read.table("ko.pred_metagenome_unstrat.tsv", header=TRUE, sep="\t", row.names=1)

#
### Alternatively, when reading in legacy TSV BIOM file (PICRUSt1 output): 
### test_ko <- read.table("/path/to/test_ko.tsv",
###                       header=TRUE, sep="\t", row.names=1, skip=1, comment.char="")
### if(length(which(colnames(test_ko) == "KEGG_Pathways")) > 0)) {
###     test_ko <- test_ko[, -which(colnames(test_ko) == "KEGG_Pathways")]
### }
#

#
### Run function to categorize all KOs by level 3 in BRITE hierarchy.
#### Level3
 ko_L3 <- categorize_by_function(table_ko, kegg_brite_map,3)
 ko_L3_sorted <- ko_L3[rownames(ko_L3), ]

#### Level2
 ko_L2 <- categorize_by_function(table_ko, kegg_brite_map,2)
 ko_L2_sorted <- ko_L2[rownames(ko_L2), ]

#### Level1
 ko_L1 <- categorize_by_function(table_ko, kegg_brite_map,1)
 ko_L1_sorted <- ko_L1[rownames(ko_L1), ]
 
 write.table(ko_L3_sorted, file="ko_L3_sorted.txt", sep="\t")
 write.table(ko_L2_sorted, file="ko_L2_sorted.txt", sep="\t")
 write.table(ko_L1_sorted, file="ko_L1_sorted.txt", sep="\t")
 

#
#
### Commands that could be used to compare the KO levels from this function with the actual output of categorize_by_function.py:
# orig_ko_L3 <- read.table("/path/to/test_ko_L3.tsv",
#                          header=TRUE, sep="\t", row.names=1, skip=1, comment.char="", quote="")
# 
# orig_ko_L3 <- orig_ko_L3[, -which(colnames(orig_ko_L3) == "KEGG_Pathways")]
# 
# orig_ko_L3 <- orig_ko_L3[-which(rowSums(orig_ko_L3) == 0),]
#
#
### The below command will be True when the output is exactly the same.
# identical(test_ko_L3_sorted, orig_ko_L3)
