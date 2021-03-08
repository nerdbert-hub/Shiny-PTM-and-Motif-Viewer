library (rvest)


# Example Protein
AC <- "P16474"
  
  
fasta_UniprotKB <- function(AC, type = "fasta"){
  
  uniprotURL <- "https://www.uniprot.org/uniprot/"
  
  # Get the Page content
  page <- read_html(paste0(uniprotURL, AC, ".", type))
  
  # Extract the clean sequence
  sequence <-   page %>% 
    html_text() %>%
    str_replace_all(., "^>.*?\\n", "") %>%
    str_replace_all(.,"\\n", "")
  
  return(sequence)
}

read_UniprotKB <- function(AC, type = "txt"){
  
  if(type == "fasta"){
    fasta_UniprotKB(AC = AC)
  }
  uniprotURL <- "https://www.uniprot.org/uniprot/"
  
  # Get the Page content
  page <- read_html(paste0(uniprotURL, AC, ".", type))
  
  # Extract the clean sequence
  sequence <-   page %>% 
    html_text() %>%
    str_replace_all(., "^>.*?\\n", "") %>%
    str_replace_all(.,"\\n", "")
  
  return(sequence)
}

read_UniprotKB()

page <- read_html(paste0(uniprotURL, AC, ".fasta"))

 
  
sequence <-   page %>% 
  html_text() %>%
  str_replace_all(., "^>.*?\\n", "") %>%
  str_replace_all(.,"\\n", "")




  gsub("^>.*?\\n", "", .) %>% 
  gsub("\\n", "", .)
