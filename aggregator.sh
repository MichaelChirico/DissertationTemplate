#!/bin/sh
# pull latest version of papers and figures to the dissertation folder

# directory where to find chapter 1
ch1wd='/home/michael/Desktop/research/Wisconsin Bargaining/analysis_code'
# copy .tex of chapter 1 to content folder here
cp "$ch1wd"/turnover_paper.tex ./content
# copy figures of chapter 1 to figures folder here
cp "$ch1wd"/figures/* ./figures
