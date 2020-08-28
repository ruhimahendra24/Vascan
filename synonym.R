# uses the "vascan_search" function from the taxize package. 
# searches all the taxons from FNA to compare presence in vasca
# Creates CSV file that gives results for each taxon in FNA

library(taxize)
library(stringi)
library(jsonlite)
library(purrr)


processFile = function(filepath){
  #creates header names for csv file
  column_names <- data.frame(TaxonName = "Taxon Name", Synonym = "Synonym",  NameAccordingTo = "Name According to" )
  con = file(filepath, "r")
  while(TRUE) {
    line = readLines (con, n=1) #loops over every line (taxon) in the text file
    if ( length(line) == 0) {
      break
    }
    
    
    v_search <- vascan_search(q = line) #this will provide us the API data in "list" format
    j_search <- vascan_search (q = line, raw = TRUE) # this provides us API data data in "json" format
    j_son = jsonlite::fromJSON(j_search) #allows us the extract data from "json" format
    
    nummatches <- v_search[[1]][2][[1]] #provides us with the number of matches
    if (nummatches == 0) {next}
      
    
    #extracting data from the "list" format
    matches <- v_search[[1]][3][[1]]
    matched_names_list <- map((map(matches, 1)) , 1)
    taxonomic_status_list <- map((map(matches, 1)) , 5)

    
    n = 0 
  
    
    for (i in matched_names_list) { #loop through every matched name
      n = n + 1 #adding 1 for every match, this will help us keep track of each match
      if (taxonomic_status_list[[n]] == "synonym"){s_search <- vascan_search(matched_names_list[[n]])}
      print(i)
      else{next}
      #print(i)
      match <- i
      matches_synonym <- s_search[[1]][3][[1]] 
      m = 0
      matched_synonym_according_to_list <-map((map(matches_synonym, 1)) , 3)
      
      for (t in map((map(matches_synonym, 1)) , 5)) {
        m = m + 1
        
        if (length(t) == 0){next}
    
        if (t == "accepted") {synonym_according_to <- matched_synonym_according_to_list[[m]]}
        print(line)
        print(match)
        newline <- data.frame(t(c(TaxonName = line, Synonym = match, NameAccordingTo = synonym_according_to )))
        #combine new taxon name to data frame
        column_names <- rbind(column_names, newline)
        
        
      }
      
      
        
      
      
      
      
      
      
      
      
     }
      
    
  }
      
  close(con)
  #write final csv file
  write.table(column_names, file ="/home/ruhimahendra24/Desktop/Vascan/Output/synonym_Taxa_wide.csv", row.names = FALSE, append = FALSE, col.names = FALSE, sep = ", " )
  
  
}

processFile('/home/ruhimahendra24/Desktop/Vascan/canada-taxa-files/canada_taxa.txt')

