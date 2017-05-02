# Penn dissertation template

This is a template for a Penn Economics/Finance/AppliedEcon style dissertation. See the example document with placeholder text [here](https://pennecon.github.io/DissertationTemplate/dissertation.pdf).

The main file is `dissertation.tex`. Add custom packages and formatting as needed to the preamble. 

Front matter (the abstract, copyright notice, dedication, and acknowledgements), are in the folder `frontmatter`, and should be modified appropriately or removed if necessary.

Include your paper contents (excluding the preamble and references, of course), where `chapterX.tex` is currently, replacing `\input{content/chapter1.tex}` with your own work.

Place all figures in the `figures` directory and refer to them in your paper with the `figures/figureX` prefix.

`aggregator.sh` can be used to pull the latest version of your paper to this folder; `body_extractor.R` gives an R script for automatically pulling the body from this file (i.e., excluding the preamble, etc.).

Check the [university's style guidelines](http://guides.library.upenn.edu/dissertation_manual/formatting) to adjust for changes.
