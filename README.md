# Penn dissertation template

This is a template for a Penn Economics/Finance/AppliedEcon style dissertation. See the example document with placeholder text [here](https://pennecon.github.io/DissertationTemplate/dissertation.pdf).

The main file is `dissertation.tex`. Add custom packages and formatting as needed to the preamble. 

Front matter (the abstract, copyright notice, dedication, and acknowledgements), are in the folder `frontmatter`, and should be modified appropriately or removed if necessary.

Include your paper contents (excluding the preamble and references, of course), where `chapterX.tex` is currently, replacing `\input{content/chapter1.tex}` with your own work.

Place all figures in the `figures` directory and refer to them in your paper with the `figures/figureX` prefix.

`aggregator.sh` can be used to pull the latest version of your papers to the `full_chapters` folder; it also runs `body_extractor.R`, which gives an R script for automatically assembling the papers together into your dissertation's format and creating the properly named files in `content/`. 

It relies on using the customized `\TAG{label}` created with the `verbatim` package in LaTeX and defined as `\newcommand{\TAG}[1]{}`, inspired by [this Q&A](http://stackoverflow.com/a/43757754/3576984). `body_extractor.R` also deals with some other idiosyncrasies of having written the paper with the `rmarkdown`/`knitr` packages, and has a fair amount of idiosyncrasies that you'll have to handle yourself -- my hope is that the examples of such covered here are enough to make generalization easier.

Here's one possible complete work flow for creating your dissertation:

 1. Fork this repository and/or clone locally.
 2. Tune `aggregator.sh` and `body_extractor.R` to the unique parts of your dissertation. Run `sh aggregator.sh` in this folder. 
 3. Define the following in `dissertation.tex`: `\thetitle`, `\theauthor`, `\theadvisor`, `\THEAUTHOR`, `\THEADVISOR`, `theyear`. Also rename/insert/delete the chapters in `\chapter{Chapter Name}` and `\input{content/_chapter_name_}`.
 4. Compose your abstract, acknowledgment, copyright, dedication, and title in `frontmatter/`.
 5. Compose your introduction and conclusion in `content/`.
 6. Build `dissertation.tex` with, e.g., `pdflatex` (I personally use the [LaTeX tools](https://github.com/SublimeText/LaTeXTools) plugin to [SublimeText 3](https://www.sublimetext.com/))

Check the [university's style guidelines](http://guides.library.upenn.edu/dissertation_manual/formatting) to adjust for changes.
