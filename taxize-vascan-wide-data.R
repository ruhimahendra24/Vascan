# uses the "vascan_search" function from the taxize package. 
# searches all the taxons from FNA to compare presence in vasca
# Creates CSV file that gives results for each taxon in FNA

library(taxize)
library(stringi)
library(jsonlite)
library(purrr)


processFile = function(filepath){
  #creates header names for csv file
  column_names <- data.frame(TaxonName = "Taxon Name", Volume = "Volume", Match = "Match", NumberofMatches = "Number of Matches", MatchNumber = "Match Number", Matches = "Matches", ScientificNameAuthorship ="Scientific Name Authorship", CanonicalName = "Canonical Name", TaxonRank = "Taxon Rank", NameAccordingTo = "Name According To", TaxonomicStatus = "Taxonic Status", HigherClassification = "Higher Classification" )
  con = file(filepath, "r")
  while(TRUE) {
    line = readLines (con, n=1) #loops over every line (taxon) in the text file

    if ( length(line) == 0) {
      break
    }
    
    l = strsplit(line, ",")[[1]][2]
    v = strsplit(line, ",")[[1]][1]
    print(l)
    
    v_search <- vascan_search(q = l) #this will provide us the API data in "list" format
    j_search <- vascan_search (q = l, raw = TRUE) # this provides us API data data in "json" format
    j_son = jsonlite::fromJSON(j_search) #allows us the extract data from "json" format
    
    nummatches <- v_search[[1]][2][[1]] #provides us with the number of matches
    if (nummatches > 0) { 
      is_match <- "yes"

    } else {
    is_match <- "no"
    }
    
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
      
      # for the taxons that do not have matches, some paramaters must be set to "NULL"
      if (nummatches < 1) {newline <-data.frame(t(c(TaxonName = l, Volume = v, Match = is_match, NumberofMatches = nummatches, MatchNumber = n ,  Matches = Matched_name, ScientificNameAuthorship = "NULL", CanonicalName = "NULL", TaxonRank = "NULL", NameAccordingTo = "NULL", TaxonomicStatus = "NULL", HigherClassification = "NULL"  )))  }
      else {newline <- data.frame(t(c(TaxonName = l, Volume = v, Match = is_match, NumberofMatches = nummatches, MatchNumber = n ,  Matches = Matched_name, ScientificNameAuthorship = Scientific_Name_authorship, CanonicalName = Canonical_Name, TaxonRank = Taxon_Rank, NameAccordingTo = Name_According_To, TaxonomicStatus = Taxonomic_status, HigherClassification = Higher_classification  )))}
      #combine new taxon name to data frame
      column_names <- rbind(column_names, newline)
      
    }
    
    
  
  }
  close(con)
  #write final csv file
  write.table(column_names, file ="/home/ruhimahendra24/Desktop/Vascan/Output/Canada_Taxa_wide.csv", row.names = FALSE, append = FALSE, col.names = FALSE, sep = ", " )
  
  
}

processFile('/home/ruhimahendra24/Desktop/Vascan/canada-taxa-files/canada_taxa.txt')

