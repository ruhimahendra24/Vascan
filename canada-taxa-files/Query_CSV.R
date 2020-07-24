source('/home/ruhimahendra24/Desktop/Vascan/query.R')

#Downloads taxon names that are present in Canada and merges all the dataframes together 
#not including duplicates.
#Creates text file to use for vascan_search function.

merge_canada <- function(x) { #combine the data frames
  canada_all <- rbind(ask_query_titles("[[Distribution::Ont.]]", "ontario_taxa.csv"),
  ask_query_titles("[[Distribution::Alta.]]", "alberta_taxa.csv"),
  ask_query_titles("[[Distribution::B.C.]]", "britishcolumbia_taxa.csv"),
  ask_query_titles("[[Distribution::Man.]]", "manitoba_taxa.csv"),
  ask_query_titles("[[Distribution::N.B.]]", "newbrunswick_taxa.csv"),
  ask_query_titles("[[Distribution::Nfld.]]", "newfoundland_taxa.csv"),
  ask_query_titles("[[Distribution::Nfld. and Labr.]]", "newfoundlandandlabrador_taxa.csv"),
  ask_query_titles("[[Distribution::N.W.T.]]", "northwestterritories_taxa.csv"),
  ask_query_titles("[[Distribution::N.S.]]", "novascotia_taxa.csv"),
  ask_query_titles("[[Distribution::Que.]]", "quebec_taxa.csv"),
  ask_query_titles("[[Distribution::P.E.I.]]", "princeedwardisland_taxa.csv"),
  ask_query_titles("[[Distribution::Nunavut.]]", "nunavut_taxa.csv"),
  ask_query_titles("[[Distribution::Sask.]]", "saskatchewan_taxa.csv"),
  ask_query_titles("[[Distribution::Yukon.]]", "yukon_taxa.csv")) 
  non_duplicate <- distinct(canada_all) #remove duplicates
  write.table(non_duplicate, "canada_taxa.txt", row.names = FALSE, col.names = FALSE, quote = FALSE) #create text file
}

