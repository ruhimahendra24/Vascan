library(taxize)
library(stringi)
library(jsonlite)
library(purrr)
processFile = function(filepath){
  print(filepath)
  column_names <- data.frame(TaxonName = "Taxon Name", Match = "Match", NumberofMatches = "Number of Matches", MatchNumber = "Match Number", Matches = "Matches", ScientificNameAuthorship ="Scientific Name Authorship", CanonicalName = "Canonical Name", TaxonRank = "Taxon Rank", NameAccordingTo = "Name According To", TaxonomicStatus = "Taxonic Status", HigherClassification = "Higher Classification" )
  con = file(filepath, "r")
  while(TRUE) {
    line = readLines (con, n=1)
    print(line)
    if ( length(line) == 0) {
      break
    }
    
    
    v_search <- vascan_search(q = line)
    j_search <- vascan_search (q = line, raw = TRUE)
    j_son = jsonlite::fromJSON(j_search)
    
    nummatches <- v_search[[1]][2][[1]]
    if (nummatches > 0) {
      is_match <- "yes"

    } else {
    is_match <- "no"
    }
    
    matches <- v_search[[1]][3][[1]]
    matched_names_list <- map((map(matches, 1)) , 1)
    matched_name_according_to_list <-map((map(matches, 1)) , 3)
    taxonomic_status_list <- map((map(matches, 1)) , 5)
    higher_classification_list <- map((map(matches, 1)) , 7)
    
    
    Scientific_name_Author_list <- j_son$results$matches[[1]][3]
    Canonical_name_list <- j_son$results$matches[[1]][4]
    Taxon_rank_list <- j_son$results$matches[[1]][5]
    
  
    n = 0
    
    for (i in matched_names_list) {
      n = n + 1
      Matched_name <- i 
      Scientific_Name_authorship <- Scientific_name_Author_list[n,1]
      Canonical_Name <- Canonical_name_list[n,1]
      Taxon_Rank <- Taxon_rank_list[n,1]
      Name_According_To = matched_name_according_to_list[[n]]
      Taxonomic_status <- taxonomic_status_list[[n]]
      Higher_classification <- higher_classification_list[[n]]
      if (nummatches < 1) {newline <-data.frame(t(c(TaxonName = line, Match = is_match, NumberofMatches = nummatches, MatchNumber = n ,  Matches = Matched_name, ScientificNameAuthorship = "NULL", CanonicalName = "NULL", TaxonRank = "NULL", NameAccordingTo = "NULL", TaxonomicStatus = "NULL", HigherClassification = "NULL"  )))  }
      else {newline <- data.frame(t(c(TaxonName = line, Match = is_match, NumberofMatches = nummatches, MatchNumber = n ,  Matches = Matched_name, ScientificNameAuthorship = Scientific_Name_authorship, CanonicalName = Canonical_Name, TaxonRank = Taxon_Rank, NameAccordingTo = Name_According_To, TaxonomicStatus = Taxonomic_status, HigherClassification = Higher_classification  )))}
      print(newline)
      
    }
    
    column_names <- rbind(column_names, newline)
  
  }
  close(con)
  write.table(column_names, file ="/home/ruhimahendra24/Desktop/Vascan/Canada_Taxa.csv", row.names = FALSE, append = FALSE, col.names = FALSE, sep = ", " )
  
  
}

processFile('/home/ruhimahendra24/Desktop/Vascan/canada_taxa.txt')

