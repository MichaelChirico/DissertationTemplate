#!/bin/sh
# pull latest version of papers and figures to the dissertation folder

# EXTRACT CHAPTER 1
# directory where to find chapter 1
ch1wd='/home/michael/Desktop/research/Wisconsin Bargaining/analysis_code'
# copy .tex of chapter 1 and references to full chapter folder here
cp "$ch1wd"/turnover_paper.tex "$ch1wd"/references.bib ./full_chapters
# rename references with chapter suffix
mv full_chapters/references.bib full_chapters/references_turnover.bib
# copy figures of chapter 1 to figures folder here
#   -- for knitr users, set fig.path = 'figures/' in your chunk options
cp "$ch1wd"/figures/* ./figures

# EXTRACT CHAPTER 2

# EXTRACT CHAPTER 3
ch3wd='/home/michael/Desktop/research/Sieg_LMI_Real_Estate_Delinquency/round_two'
cp "$ch3wd"/round_two_paper.tex "$ch3wd"/references.bib ./full_chapters
mv full_chapters/references.bib full_chapters/references_procrastination.bib
# no figures in chapter 3

# ASSEMBLE
Rscript body_extractor.R
