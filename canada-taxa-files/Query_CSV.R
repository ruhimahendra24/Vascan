source('./canada-taxa-files/query.R')

#Downloads taxon names that are present in Canada and merges all the dataframes together 
#not including duplicates.
#Creates text file to use for vascan_search function.

merge_canada <- function(x) { #combine the data frames

  canada_all <- rbind(
  ask_query_titles_properties("[[Distribution::Ont.]]|?Volume", "Province Files/ontario_taxa.csv"),
  ask_query_titles_properties("[[Distribution::Alta.]]|?Volume", "Province Files/alberta_taxa.csv"),
  ask_query_titles_properties("[[Distribution::B.C.]]|?Volume", "Province Files/britishcolumbia_taxa.csv"),
  ask_query_titles_properties("[[Distribution::Man.]]|?Volume", "Province Files/manitoba_taxa.csv"),
  ask_query_titles_properties("[[Distribution::N.B.]]|?Volume", "Province Files/newbrunswick_taxa.csv"),
  ask_query_titles_properties("[[Distribution::Nfld.]]|?Volume", "Province Files/newfoundland_taxa.csv"),
  ask_query_titles_properties("[[Distribution::Nfld. and Labr.]]|?Volume", "Province Files/newfoundlandandlabrador_taxa.csv"),
  ask_query_titles_properties("[[Distribution::N.W.T.]]|?Volume", "Province Files/northwestterritories_taxa.csv"),
  ask_query_titles_properties("[[Distribution::N.S.]]|?Volume", "Province Files/novascotia_taxa.csv"),
  ask_query_titles_properties("[[Distribution::Que.]]|?Volume", "Province Files/quebec_taxa.csv"),
  ask_query_titles_properties("[[Distribution::P.E.I.]]|?Volume", "Province Files/princeedwardisland_taxa.csv"),
  ask_query_titles_properties("[[Distribution::Nunavut.]]|?Volume", "Province Files/nunavut_taxa.csv"),
  ask_query_titles_properties("[[Distribution::Sask.]]|?Volume", "Province Files/saskatchewan_taxa.csv"),
  ask_query_titles_properties("[[Distribution::Yukon.]]|?Volume", "Province Files/yukon_taxa.csv"))
  non_duplicate <- distinct(canada_all) #remove duplicates
  write.table(non_duplicate, "canada_taxa.txt", row.names = FALSE, col.names = FALSE, quote = FALSE, sep = ",")} #create text file




