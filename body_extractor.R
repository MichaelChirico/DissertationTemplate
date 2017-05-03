#!/bin/Rscript
# CHAPTER 1: TURNOVER
ch1 = readLines('full_chapters/turnover_paper.tex')
body_start = grep('\\TAG{BEGIN_BODY}', ch1, fixed = TRUE) + 1L
#bibliography included at end of dissertation
body_end = grep('\\TAG{END_BODY}', ch1, fixed = TRUE) - 1L
writeLines(ch1[body_start:body_end], 'content/turnover.tex')

# CHAPTER 2: 

# CONCATENATE INDIVIDUAL REFERENCES
## (note designed to deal with duplicated references...
##  maybe see bibtex or RefManageR packages)
full_bib = c(readLines('full_chapters/references.bib'))

writeLines(full_bib, 'references.bib')
