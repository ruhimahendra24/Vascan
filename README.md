# VALIDATING TAXA IN FNA WITH TAXA IN VASCAN

## Project

The purpose of this project is to validate the taxa that are present in FNA with those that are present in VASCAN. This will allow the users to determine which taxa are not present in FNA... edit  

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

2)`canada-taxa-files/query.R`

This script was slightly modified from https://github.com/jocelynpender/fna-query/blob/master/R/src/query.R

This script contains the function to download a list of taxa that are distributed in a certain location. In this case, we want all the taxa in Canada.

3) `taxize-vascan-long-data.R` or `taxize-vascan-wide-data.R`

Validate all the names from the newly curated text file against the names from the VASCAN API.

### CSV files

The output of this project creates a final CSV file that shows the taxa from FNA and whether or not each taxa has a "match" in the VASCAN API.

Two different output files are produced depending on if "wide data" (`Canada_Taxa.CSV`) or "long data" (`Canada_Taxa_long.CSV`) is wanted.

Here is a preview of `Canada_Taxa.CSV`:

|Taxon Name          |Match|Number of Matches|Match Number|Matches                         |Scientific Name Authorship|Canonical Name|Taxon Rank|Name According To                                                                                                                                 |Taxonic Status|Higher Classification                                                                     |
|--------------------|-----|-----------------|------------|--------------------------------|--------------------------|--------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------|--------------|------------------------------------------------------------------------------------------|
|Abies balsamea      |yes  |1                |1           |Abies balsamea (Linnaeus) Miller|(Linnaeus) Miller         |Abies balsamea|species   |FNA Editorial Committee. 1993. Flora of North America north of Mexico. Volume 2: Pteridophytes and Gymnosperms. Oxford University Press, New York.|accepted      |Equisetopsida;Pinidae;Pinales;Pinaceae;Abies;Abies sect. Balsamea;Abies subsect. Laterales|
|Abies bifolia       |yes  |1                |1           |Abies bifolia A. Murray         |A. Murray                 |Abies bifolia |species   |FNA Editorial Committee. 1993. Flora of North America north of Mexico. Volume 2: Pteridophytes and Gymnosperms. Oxford University Press, New York.|accepted      |Equisetopsida;Pinidae;Pinales;Pinaceae;Abies;Abies sect. Balsamea;Abies subsect. Laterales|
|Abietinella abietina|no   |0                |1           | NA                             |NULL                      |NULL          |NULL      |NULL                                                                                                                                              |NULL          |NULL                                                                                      |

Here is a preview of `Canada_Taxa_long.CSV`:

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

