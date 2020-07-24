# uses the "vascan_search" function from the taxize package. 
# searches all the taxons from FNA to compare presence in vasca
# Creates CSV file (longer data vs. wider data) that gives results for each taxon in FNA

library(taxize)
library(stringi)
library(jsonlite)
library(purrr)
processFile = function(filepath){
  #creates header names for csv file
  column_names <- data.frame(TaxonName = "Taxon Name", Match = "Match", Variable = "Variable", Value = "Value")
  con = file(filepath, "r")
  while(TRUE) { #loops over every line (taxon) in the text file
    line = readLines (con, n=1)
    print(line)
    if ( length(line) == 0) {
      break
    }
    
    
    v_search <- vascan_search(q = line) #this will provide us the API data in "list" format
    j_search <- vascan_search (q = line, raw = TRUE) # this provides us API data data in "json" format
    j_son = jsonlite::fromJSON(j_search) #allows us the extract data from "json" format
    
    nummatches <- v_search[[1]][2][[1]] #provides us with the number of matches
   
    #extracting data from the "list" format
    matches <- v_search[[1]][3][[1]]
    matched_names_list <- map((map(matches, 1)) , 1)
    matched_name_according_to_list <-map((map(matches, 1)) , 3)
    taxonomic_status_list <- map((map(matches, 1)) , 5)
    higher_classification_list <- map((map(matches, 1)) , 7)
    
    # some data isn't made available in "list" format and therefore must extract it from "json" format
    Scientific_name_Author_list <- j_son$results$matches[[1]][3]
    Canonical_name_list <- j_son$results$matches[[1]][4]
    Taxon_rank_list <- j_son$results$matches[[1]][5]
    
    
    n = 0
    
    for (i in matched_names_list) { #loop through every matched name
      n = n + 1 #adding 1 for every match, this will help us keep track of each match
      Matched_name <- i 
      Scientific_Name_authorship <- Scientific_name_Author_list[n,1]
      Canonical_Name <- Canonical_name_list[n,1]
      Taxon_Rank <- Taxon_rank_list[n,1]
      Name_According_To = matched_name_according_to_list[[n]]
      Taxonomic_status <- taxonomic_status_list[[n]]
      Higher_classification <- higher_classification_list[[n]]
      
      #there are some taxons that do have matches, but they do not contain information for higher classification
      if (class(Higher_classification) == "NULL"){Higher_classification <- "NULL"}
      else {Higher_classification <-higher_classification_list[[n]] }
      
      #to make the formal of the data long, a new row is created for each variable
      if (nummatches > 0) {newline <-data.frame(t(c(TaxonName = line, Match = Matched_name, Variable = "Match Number", Value = n)))
      newline2 <- data.frame(t(c(TaxonName = line, Match = Matched_name, Variable = "Scientific Name Authorship", Value = Scientific_Name_authorship)))
      newline3 <-data.frame(t(c(TaxonName = line, Match = Matched_name, Variable = "Taxon Rank", Value = Taxon_Rank)))
      newline4 <- data.frame(t(c(TaxonName = line, Match = Matched_name, Variable = "Name According To", Value = Name_According_To)))
      newline5 <- data.frame(t(c(TaxonName = line, Match = Matched_name, Variable = "Canonical Name", Value = Canonical_Name)))
      newline6 <-data.frame(t(c(TaxonName = line, Match = Matched_name, Variable = "Taxonomic Status", Value = Taxonomic_status))) 
      newline7 <-data.frame(t(c(TaxonName = line, Match = Matched_name, Variable = "Higher Classification", Value = Higher_classification))) 
      column_names <- rbind(column_names, newline, newline2, newline3, newline4, newline5, newline6, newline7) }
      
      #if there is no match, only one line is created
      else {newline <- data.frame(t(c(TaxonName = line, Match = "NA", Variable = "NA", Value = "NA"  )))
      column_names <- rbind(column_names, newline)}
      
      
    }
    
    
    
  }
  close(con)
  write.table(column_names, file ="/home/ruhimahendra24/Desktop/Vascan/Canada_Taxa_long.csv", row.names = FALSE, append = FALSE, col.names = FALSE, sep = ", " )
  
  
}

#processFile('/home/ruhimahendra24/Desktop/Vascan/canada_taxa.txt')
