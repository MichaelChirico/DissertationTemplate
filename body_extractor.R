#!/bin/Rscript
# CHAPTER 1: TURNOVER
ch1_dir = 
  paste0('~/Desktop/research/Wisconsin Bargaining/analysis_code/')
ch1 = readLines(paste0(ch1_dir, 'turnover_paper.tex'))
body_start = grep('\\maketitle', ch1, fixed = TRUE) + 1L
#bibliography included at end of dissertation
body_end = grep('\\section*{References}', ch1, fixed = TRUE) - 1L
writeLines(ch1[body_start:body_end], 'content/sail_chapter.tex')

# CHAPTER 2: 

# CONCATENATE INDIVIDUAL REFERENCES
## (note designed to deal with duplicated references...
##  maybe see bibtex or RefManageR packages)
full_bib = c(readLines(paste0(ch1_dir, 'references.bib')))

writeLines(full_bib, 'references.bib')
