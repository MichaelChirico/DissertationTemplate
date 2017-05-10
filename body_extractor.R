#!/bin/Rscript

###############################################################################
#                               HELPER FUNCTIONS                              #
###############################################################################

## find first what in x forwards (dir = '+') 
##   or backwards (dir = '-') from start
find_nearest = function(x, what, start, dir) {
  ii = 0L
  #increment forward or backward?
  increment = if (dir == '+') `+` else `-`
  while (TRUE) {
    if (grepl(what, x[increment(start, ii)], fixed = TRUE)) break
    ii = ii+1L
  }
  increment(start, ii)
}

## some tables that looked good sideways turned out horrible
##   in dissertation format; fix them to vertical
convert_sideways = function(x, lbl) {
  #find the nearest \begin{sidewaystable} before \label{lbl}
  lbl_idx = grep(paste0('\\label{', lbl, '}'), x, fixed = TRUE)
  start_end = c(find_nearest(x, 'sidewaystable', lbl_idx, '-'),
                find_nearest(x, 'sidewaystable', lbl_idx, '+'))
  x[start_end] = gsub('sidewaystable', 'table', x[start_end])
  x
}

##dissertation margins are devastating to large tables --
##  my approach is just to shrink the table until it fits.
##  I find the percentages by trial and error.
add_adjust = function(x, lbl, p, dir = '-') {
  #find the nearest \begin{table} before \label{lbl}
  lbl_idx = grep(paste0('\\label{', lbl, '}'), x, fixed = TRUE)
  #if caption is above table, use dir = '+'
  start_tab = find_nearest(x, 'begin{tabular', lbl_idx, dir)
  end_tab = find_nearest(x, 'end{tabular', lbl_idx, dir)
  c(x[1L:(start_tab - 1L)],
    paste0('\\begin{adjustbox}{width=\\textwidth,totalheight=',
           p,'\\textheight,keepaspectratio}'),
    x[start_tab:end_tab], '\\end{adjust_box}',
    x[(end_tab + 1L):length(x)])
}

## if your captions are running to long/large, shrink the font
scriptsize_caption = function(x, lbl) {
  #assumption: \caption precedes \label and there's nothing between
  lbl_idx = grep(paste0('\\label{', lbl, '}'), x, fixed = TRUE)
  start_idx = find_nearest(x, 'caption', lbl_idx, '-')
  #if caption runs more than one line in TeX, a pain
  if (lbl_idx - start_idx > 1L) {
    caption_coll = paste(x[start_idx:(lbl_idx - 1L)], collapse = ' ')
    fix_caption = gsub('\\caption\\{(.*)\\}', 
                        '\\caption{\\scriptsize{\\1}}',
                        caption_coll)
    x = c(x[1L:(start_idx - 1L)], fix_caption, x[lbl_idx:length(x)])
  } else {
    x[start_idx] = gsub('\\caption\\{(.*)\\}', 
                        '\\caption{\\scriptsize{\\1}}',
                        x[start_idx])
  }
  x
}

###############################################################################
#                                  CHAPTER 1                                  #
###############################################################################
ch1 = readLines('full_chapters/turnover_paper.tex')

#knitr-produced citations create internal links,
#  but I have one chapter with referential links,
#  so I need to convert these to referential links
#  (or vice versa, but this is pretty straightforward)
#  (done now since there are also citations in appendix)
ch1 = gsub('\\\\protect\\\\hyperlink\\{ref-([^}]*)\\}\\{[0-9]{4}\\}',
           '\\citeyear{\\1}', ch1)

body_start = grep('\\TAG{BEGIN_BODY}', ch1, fixed = TRUE) + 1L
#bibliography included at end of dissertation
body_end = grep('\\TAG{END_BODY}', ch1, fixed = TRUE) - 1L

app_start = grep('\\TAG{BEGIN_APPENDIX}', ch1, fixed = TRUE) + 1L
app_end = grep('\\TAG{END_APPENDIX}', ch1, fixed = TRUE) - 1L

ch1_app = ch1[app_start:app_end]

ch1 = ch1[body_start:body_end]

ch1 = convert_sideways(ch1, 'tbl:reg_lpm')
ch1 = convert_sideways(ch1, 'tbl:reg_lpm_fe')
ch1 = convert_sideways(ch1, 'tbl:reg_mlogit')

# >30 was compiling fine in my other document, must be
#   of the packages in the dissertation wasn't playing nice
ch1 = gsub('>30', '$>$30', ch1)

ch1 = add_adjust(ch1, 'tbl:change_by_quartile', .9)
ch1 = add_adjust(ch1, 'tbl:reg_lpm', .85)
ch1 = add_adjust(ch1, 'tbl:reg_lpm_fe', .85)
ch1 = add_adjust(ch1, 'tbl:reg_mlogit', .9)

ch1 = scriptsize_caption(ch1, 'tbl:change_by_quartile')
ch1 = scriptsize_caption(ch1, 'tbl:reg_lpm')
ch1 = scriptsize_caption(ch1, 'tbl:reg_lpm_fe')
ch1 = scriptsize_caption(ch1, 'tbl:reg_mlogit')

#results section has duplicate label over all chapters:
ch1 = gsub('\\section{Results}\\label{results}',
           '\\section{Results}\\label{results-ch1}', ch1)
ch1 = gsub('\\section{Literature Review}\\label{literature-review}',
           '\\section{Literature Review}\\label{literature-review-ch1}', ch1)

#identify by hand instances where referring to "paper"
#  when should be referring to "chapter"
ch1 = gsub('paper(, there| of restricting|\\. Data)', 
           'chapter\\1', ch1)

###############################################################################
#                                  CHAPTER 2                                  #
###############################################################################
# ch2 = readLines('full_chapters/sail_paper.tex')
# 
# body_start = grep('\\TAG{BEGIN_BODY}', ch2, fixed = TRUE) + 1L
# body_end = grep('\\TAG{END_BODY}', ch2, fixed = TRUE) - 1L
# ch2 = ch2[body_start:body_end]
# 
# ch2 = gsub('\\\\protect\\\\hyperlink\\{ref-([^}]*)\\}\\{[0-9]{4}\\}',
#            '\\citeyear{\\1}', ch2)
# 
# ch2 = add_adjust(ch2, 'tbl:desc', .9)
# 
# ch2 = gsub('\\section{Results}\\label{results}',
#            '\\section{Results}\\label{results-ch1}', ch2)
# ch2 = gsub('\\section{Literature Review}\\label{literature-review}',
#            '\\section{Literature Review}\\label{literature-review-ch1}', ch2)
# 
# #manually identified just one
# ch2 = gsub('This paper focuses', 'This chapter focuses', ch2, fixed = TRUE)

###############################################################################
#                                  CHAPTER 3                                  #
###############################################################################
ch3 = readLines('full_chapters/round_two_paper.tex')
body_start = grep('\\TAG{BEGIN_BODY}', ch3, fixed = TRUE) + 1L
body_end = grep('\\TAG{END_BODY}', ch3, fixed = TRUE) - 1L

app_start = grep('\\TAG{BEGIN_APPENDIX}', ch3, fixed = TRUE) + 1L
app_end = grep('\\TAG{END_APPENDIX}', ch3, fixed = TRUE) - 1L

ch3_app = ch3[app_start:app_end]

ch3 = ch3[body_start:body_end]

#this paper uses \citeA (which is just \cite in this style)
#  and \citeyear (which is actually \citeyearpar)
ch3 = gsub('citeA', 'cite', ch3, fixed = TRUE)
ch3 = gsub('citeyear', 'citeyearpar', ch3, fixed = TRUE)

# only one manually-identified of reference as a paper
ch3 = gsub('in the paper', 'in this chapter', ch3)

###############################################################################
#                                BUILD CHAPTERS                               #
###############################################################################
#do this in separate section so you can more easily sandbox all the chapters
#  without overwriting the file in the content folder accidentally
writeLines(ch1, 'content/turnover.tex')
# writeLines(ch2, 'content/turnover.tex')
writeLines(ch3, 'content/procrastination.tex')

###############################################################################
#                              BUILD BIBLIOGRAPHY                             #
###############################################################################
## (not designed to deal with duplicated references...
##  maybe see bibtex or RefManageR packages)
full_bib = unlist(lapply(c('full_chapters/references_turnover.bib',
                           'full_chapters/references_procrastination.bib',
                           'full_chapters/references_sail.bib'),
                         readLines))

writeLines(full_bib, 'references.bib')

###############################################################################
#                                BUILD APPENDIX                               #
###############################################################################
## since we \include{appendix} in the main 
##   dissertation body, we have to manually "include"
##   the appendices here (since recursive includes are illegal --
##   only the top-level tex file can have \includes)

ch3_app = add_adjust(ch3_app, 'sh_logit_rob', .9, '+')

app = c('\\begin{appendices}',
        '    \\addtocontents{toc}{\\protect\\setcounter{tocdepth}{1}}',
        '    \\makeatletter',
        '    \\addtocontents{toc}{%',
        '        \\begingroup',
        '        \\let\\protect\\l@chapter\\protect\\l@section',
        '        \\let\\protect\\l@section\\protect\\l@subsection',
        '    }', '',
        '\\chapter{Appendix to Chapter 1}', '',
        ch1_app, '',
        '\\chapter{Appendix to Chapter 3}', '',
        ch3_app, '',
        '\\end{appendices}')

writeLines(app, 'content/appendix.tex')
