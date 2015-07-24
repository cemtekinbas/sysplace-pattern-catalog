TEMPFILES = "*.aux" "*.log" "*.dvi" "*.synctex.gz" "*.4ct" "*.4tc" "*.tmp" "*.lg" "*.idv" "*.xref" "*.bbl" "*.lof" "*.blg" "*.out"


clean: delete-temps
	find output -type f | xargs rm -f

delete-temps:
	for f in $(TEMPFILES) ; do find . -name $$f  | xargs rm -f ; done

build:
	# create output dirs (if not existing)
	mkdir -p output/pdf
	mkdir -p output/temp/pdf
	# run all .tex files through pdflatex, except for the template and header ones
	for file in `find . -name "*.tex" ! -name "template.tex" ! -name "header.tex" -printf "%f\n"`; do \
		(cd patterns && echo "building $$file" && pdflatex -interaction=nonstopmode $$file); \
	done
	# move pdf files to output
	mv patterns/*.pdf output/pdf/
	# move all temp files to output
	for f in $(TEMPFILES) ; do find patterns -name $$f -exec mv {} -t output/temp/pdf \; ; done

build-web:

