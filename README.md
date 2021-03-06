# VALIDATING TAXA IN FNA WITH TAXA IN VASCAN

## Project

The purpose of this project is to search the taxa that are present in FNA with those that are present in the VASCAN API. If there is a "match", we can determine if the matched taxon from FNA is an accepted name used in VASCAN or a synonym. The output of this project returns a CSV file that tells us if there has been a match for every taxon in FNA and what is the status of the match. 

## Dependencies

`R version 4.0.2`

R packages:

`tidyverse`
`WikipediaR`
`taxize`
`stringi`
`jsonlite`
`purr`

## Repository

### Scripts

This repository contains three main scripts:

1) `canada-taxa-files/QUERY-CSV.R`

Download the taxa found in Canada from the FNA API and merge all the taxa names together in a text file.

2) `canada-taxa-files/query.R`

This script contains the function to download a list of taxa that are distributed in a certain location. In this case, we want all the taxa in Canada.

This script was slightly modified from https://github.com/jocelynpender/fna-query/blob/master/R/src/query.R The function `ask_query_titles()` was modified to return a data frame. 

3) `taxize-vascan-long-data.R` or `taxize-vascan-wide-data.R`

Validate all the names from the newly curated text file against the names from the VASCAN API.

### CSV files

The output of this project creates a final CSV file that shows the taxa from FNA and whether or not each taxa has a "match" in the VASCAN API.

Two different output files are produced depending on if "wide data" (`Canada_Taxa.CSV`) or "long data" (`Canada_Taxa_long.CSV`) is wanted.

Here is a preview of `Canada_Taxa_wide.CSV` (wide data):

|Taxon Name          |Match|Number of Matches|Match Number|Matches                         |Scientific Name Authorship|Canonical Name|Taxon Rank|Name According To                                                                                                                                 |Taxonic Status|Higher Classification                                                                     |
|--------------------|-----|-----------------|------------|--------------------------------|--------------------------|--------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------|--------------|------------------------------------------------------------------------------------------|
|Abies balsamea      |yes  |1                |1           |Abies balsamea (Linnaeus) Miller|(Linnaeus) Miller         |Abies balsamea|species   |FNA Editorial Committee. 1993. Flora of North America north of Mexico. Volume 2: Pteridophytes and Gymnosperms. Oxford University Press, New York.|accepted      |Equisetopsida;Pinidae;Pinales;Pinaceae;Abies;Abies sect. Balsamea;Abies subsect. Laterales|
|Abies bifolia       |yes  |1                |1           |Abies bifolia A. Murray         |A. Murray                 |Abies bifolia |species   |FNA Editorial Committee. 1993. Flora of North America north of Mexico. Volume 2: Pteridophytes and Gymnosperms. Oxford University Press, New York.|accepted      |Equisetopsida;Pinidae;Pinales;Pinaceae;Abies;Abies sect. Balsamea;Abies subsect. Laterales|
|Abietinella abietina|no   |0                |1           | NA                             |NULL                      |NULL          |NULL      |NULL                                                                                                                                              |NULL          |NULL                                                                                      |

Here is a preview of `Canada_Taxa_long.CSV` (long data):

|Taxon Name          |Match|Variable|Value|
|--------------------|-----|--------|-----|
|Abies bifolia       |Abies bifolia A. Murray|Match Number|1    |
|Abies bifolia       |Abies bifolia A. Murray|Scientific Name Authorship|A. Murray|
|Abies bifolia       |Abies bifolia A. Murray|Taxon Rank|species|
|Abies bifolia       |Abies bifolia A. Murray|Name According To|FNA Editorial Committee. 1993. Flora of North America north of Mexico. Volume 2: Pteridophytes and Gymnosperms. Oxford University Press, New York.|
|Abies bifolia       |Abies bifolia A. Murray|Canonical Name|Abies bifolia|
|Abies bifolia       |Abies bifolia A. Murray|Taxonomic Status|accepted|
|Abies bifolia       |Abies bifolia A. Murray|Higher Classification|Equisetopsida;Pinidae;Pinales;Pinaceae;Abies;Abies sect. Balsamea;Abies subsect. Laterales|
|Abietinella abietina|NA   |NA      |NA   |

## Workflow
<img width="638" alt="Capture" src="https://user-images.githubusercontent.com/65621746/88696053-bd8b0100-d0d0-11ea-8bb3-24a00978d0b6.PNG">

### Cloning the repository

To clone this repository onto your local computer, open your terminal and type `git clone https://github.com/ruhimahendra24/Vascan.git`

### Generating the text file 

To generate the text file with the list of Taxa from FNA, we must run `canada-taxa-files/QUERY-CSV.R`. Make sure that you have installed the R packages `tidyverse` and
`WikipediaR` to be able to run this script. 

To install the packages in R, type this into the console : `install.packages('tidyverse')` or `install.packages('WikipediaR')`.

In this script, we want to run the function `merge_canada`, to do this input `merge_canada()` into the console. 

This will download a csv file of taxa that are located in each province in Canada. The function will also merge all the csv files together to create a final text file. The text file can be found in `canada-taxa-files/canada_taxa.txt`

### Generating the final CSV file

To generate the final CSV file, we must run  `taxize-vascan-long-data.R` or `taxize-vascan-wide-data.R`, depending on the size of the data. 

Make sure you have installed the R packages `taxize` , `stringi` , `jsonlite` and `purr`. 

In this script, we want to run the function `processfile(filepath)` where filepath is the pathway link of where the text file is located. The final CSV file can be found in the `/Output` folder. 


