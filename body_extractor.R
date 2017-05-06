#!/bin/Rscript
# CHAPTER 1: TURNOVER
ch1 = readLines('full_chapters/turnover_paper.tex')
body_start = grep('\\TAG{BEGIN_BODY}', ch1, fixed = TRUE) + 1L
#bibliography included at end of dissertation
body_end = grep('\\TAG{END_BODY}', ch1, fixed = TRUE) - 1L
writeLines(ch1[body_start:body_end], 'content/turnover.tex')

# CHAPTER 3: PROCRASTINATION
ch3 = readLines('full_chapters/round_two_paper.tex')
body_start = grep('\\TAG{BEGIN_BODY}', ch3, fixed = TRUE) + 1L
body_end = grep('\\TAG{END_BODY}', ch3, fixed = TRUE) - 1L
writeLines(ch3[body_start:body_end], 'content/procrastination.tex')

apdx_start = grep('\\TAG{BEGIN_APPENDIX}', ch3, fixed = TRUE) + 1L
apdx_end = grep('\\TAG{END_APPENDIX}', ch3, fixed = TRUE) - 1L
writeLines(ch3[apdx_start:apdx_end], 'content/appendix_procrastination.tex')

# CONCATENATE INDIVIDUAL REFERENCES
## (note designed to deal with duplicated references...
##  maybe see bibtex or RefManageR packages)
full_bib = unlist(lapply(c('full_chapters/references_turnover.bib',
                           'full_chapters/references_procrastination.bib'),
                         readLines))

writeLines(full_bib, 'references.bib')
