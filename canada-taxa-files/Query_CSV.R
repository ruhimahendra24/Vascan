source('./canada-taxa-files/query.R')

#Downloads taxon names that are present in Canada and merges all the dataframes together 
#not including duplicates.
#Creates text file to use for vascan_search function.

merge_canada <- function(x) { #combine the data frames
  canada_all <- rbind(ask_query_titles("[[Distribution::Ont.]]", "./canada-taxa-files/Province_Files/ontario_taxa.csv"),
  ask_query_titles("[[Distribution::Alta.]]", "./canada-taxa-files/Province_Files/alberta_taxa.csv"),
  ask_query_titles("[[Distribution::B.C.]]", "./canada-taxa-files/Province_Files/britishcolumbia_taxa.csv"),
  ask_query_titles("[[Distribution::Man.]]", "./canada-taxa-files/Province_Files/manitoba_taxa.csv"),
  ask_query_titles("[[Distribution::N.B.]]", "./canada-taxa-files/Province_Files/newbrunswick_taxa.csv"),
  ask_query_titles("[[Distribution::Nfld.]]", "./canada-taxa-files/Province_Files/newfoundland_taxa.csv"),
  ask_query_titles("[[Distribution::Nfld. and Labr.]]", "./canada-taxa-files/Province_Files/newfoundlandandlabrador_taxa.csv"),
  ask_query_titles("[[Distribution::N.W.T.]]", "./canada-taxa-files/Province_Files/northwestterritories_taxa.csv"),
  ask_query_titles("[[Distribution::N.S.]]", "./canada-taxa-files/Province_Files/novascotia_taxa.csv"),
  ask_query_titles("[[Distribution::Que.]]", "./canada-taxa-files/Province_Files/quebec_taxa.csv"),
  ask_query_titles("[[Distribution::P.E.I.]]", "./canada-taxa-files/Province_Files/princeedwardisland_taxa.csv"),
  ask_query_titles("[[Distribution::Nunavut.]]", "./canada-taxa-files/Province_Files/nunavut_taxa.csv"),
  ask_query_titles("[[Distribution::Sask.]]", "./canada-taxa-files/Province_Files/saskatchewan_taxa.csv"),
  ask_query_titles("[[Distribution::Yukon.]]", "./canada-taxa-files/Province_Files/yukon_taxa.csv")) 
  non_duplicate <- distinct(canada_all) #remove duplicates
  write.table(non_duplicate, "./canada-taxa-files/canada_taxa.txt", row.names = FALSE, col.names = FALSE, quote = FALSE) #create text file
}

