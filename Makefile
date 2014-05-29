# basic info
source=Documentation/*.md
img=Documentation/img/*.*
title='Server for dummies'
filename='server-for-dummies'

# dist path
markdown=dist/markdown
epub=dist/epub
pdf=dist/pdf

all: prepare markdown epub pdf mobi finish

prepare:
	cp -R Documentation/img/ img
	rm README.md
	cp Documentation/01_started.md .
	mv 01_started.md README.md

markdown:
	mkdir -p $(markdown)
	cp -R Documentation/img/ $(markdown)/img
	awk 'FNR==1{print ""}{print}' $(source) > $(markdown)/$(filename).md

epub:
	mkdir -p $(epub)
	pandoc -s $(markdown)/$(filename).md --normalize --smart -t epub -o $(epub)/$(filename).epub \
		--epub-metadata Documentation/metadata.xml \
		--epub-stylesheet Documentation/css/epub.css \
		--epub-cover-image Documentation/img/cover.jpg \
		--title-prefix $(title) \
		--normalize \
		--smart \
		--toc

pdf:
	# You need `pdflatex`
	# OS X: http://www.tug.org/mactex/
	# Then find its path: find /usr/ -name "pdflatex"
	# Then symlink it: ln -s /path/to/pdflatex /usr/local/bin
	mkdir -p $(pdf)
	pandoc -s $(markdown)/$(filename).md -o $(pdf)/$(filename).pdf \
		--title-prefix $(title) \
		--normalize \
		--smart \
		--toc \
		--latex-engine=`which xelatex`

mobi:
	# Download: http://www.amazon.com/gp/feature.html?ie=UTF8&docId=1000765211
	# Symlink bin: ln -s /path/to/kindlegen /usr/local/bin
	kindlegen $(epub)/$(filename).epub

finish:
	rm -rf img/

clean:
	rm -rf img
	rm -r $(markdown)
	rm -r $(epub)
	rm -rf $(pdf)
	rm README.md
