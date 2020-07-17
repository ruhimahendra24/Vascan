library(taxize)
library(stringi)
library(jsonlite)
source('/home/ruhimahendra24/Desktop/query.R')
processFile = function(filepath){
  print(filepath)
  column_names <- data.frame(TaxonName = "Taxon Name", Match = "Match", NumberofMatches = "Number of Matches", Matches = "Matches")
  con = file(filepath, "r")
  while(TRUE) {
    line = readLines (con, n=1)
    if ( length(line) == 0) {
      break
    }
    #x <- (strsplit(line," "))
    Name <- stri_trans_general(line, id= "Title")
    print(Name)
    v_search <- vascan_search(q = Name)
    nummatches <- v_search[[1]][2][[1]]
    if (nummatches > 0) {
      is_match <- "yes"
    } else {
    is_match <- "no"
    }
    
    matches <- v_search[[1]][3][[1]]
    
    matched_names_list <- map((map(matches, 1)) , 1)
    matched_names_string <- paste0(matched_names_list, collapse = ", ")
  
    newline <- data.frame(t(c(TaxonName = Name, Match = is_match, NumberofMatches = nummatches, Matches = matched_names_string)))
    
    column_names <- rbind(column_names, newline)
  
  }
  close(con)
  write.table(column_names, file ="/home/ruhimahendra24/Desktop/Vascan/Canada_Taxa.csv", row.names = FALSE, append = FALSE, col.names = FALSE, sep = ", " )
  
  
}

processFile('/home/ruhimahendra24/Desktop/Vascan/canada_taxa.txt')

