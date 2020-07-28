source('/home/ruhimahendra24/Desktop/Vascan/canada-taxa-files/query.R')

#Downloads taxon names that are present in Canada and merges all the dataframes together 
#not including duplicates.
#Creates text file to use for vascan_search function.

merge_canada <- function(x) { #combine the data frames
  canada_all <- rbind(ask_query_titles("[[Distribution::Ont.]]", "ontario_taxa.csv"),
  ask_query_titles("[[Distribution::Alta.]]", "Province Files/alberta_taxa.csv"),
  ask_query_titles("[[Distribution::B.C.]]", "Province Files/britishcolumbia_taxa.csv"),
  ask_query_titles("[[Distribution::Man.]]", "Province Files/manitoba_taxa.csv"),
  ask_query_titles("[[Distribution::N.B.]]", "Province Files/newbrunswick_taxa.csv"),
  ask_query_titles("[[Distribution::Nfld.]]", "Province Files/newfoundland_taxa.csv"),
  ask_query_titles("[[Distribution::Nfld. and Labr.]]", "Province Files/newfoundlandandlabrador_taxa.csv"),
  ask_query_titles("[[Distribution::N.W.T.]]", "Province Files/northwestterritories_taxa.csv"),
  ask_query_titles("[[Distribution::N.S.]]", "Province Files/novascotia_taxa.csv"),
  ask_query_titles("[[Distribution::Que.]]", "Province Files/quebec_taxa.csv"),
  ask_query_titles("[[Distribution::P.E.I.]]", "Province Files/princeedwardisland_taxa.csv"),
  ask_query_titles("[[Distribution::Nunavut.]]", "Province Files/nunavut_taxa.csv"),
  ask_query_titles("[[Distribution::Sask.]]", "Province Files/saskatchewan_taxa.csv"),
  ask_query_titles("[[Distribution::Yukon.]]", "Province Files/yukon_taxa.csv")) 
  non_duplicate <- distinct(canada_all) #remove duplicates
  write.table(non_duplicate, "canada_taxa.txt", row.names = FALSE, col.names = FALSE, quote = FALSE) #create text file
}

