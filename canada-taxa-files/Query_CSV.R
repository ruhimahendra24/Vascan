source('./canada-taxa-files/query.R')

#Downloads taxon names that are present in Canada and merges all the dataframes together 
#not including duplicates.
#Creates text file to use for vascan_search function.

run_province_query <- function(province = "Ont.") {
  prov_query_string <- paste("[[Distribution::", province, "]]", sep = "")
  prov_file_name <- paste("./canada-taxa-files/Province_Files/", province, "_taxa.csv", sep = "")
  ask_query_titles(prov_query_string, prov_file_name)
}

merge_canada <- function(provinces = c("Ont.", "Alta.", "B.C.", "Man.", "N.B.", "Nfld.", 
                                       "Nfld. and Labr.", "N.W.T.", "N.S.", "Que.", 
                                       "P.E.I.", "Nunavut.", "Sask.", "Yukon.")) { 
  canada_all <- map(provinces, run_province_query)
  non_duplicate <- canada_all %>% bind_rows() %>% distinct()
  write.table(non_duplicate, "./canada-taxa-files/canada_taxa.txt", row.names = FALSE, col.names = FALSE, quote = FALSE) #create text file
}