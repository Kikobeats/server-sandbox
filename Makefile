source=0*/*.md
title='Server Sandbox'
filename='server-sandbox'
# 02.\ Understand/**/*.md 03.\ Services/**/*.md

all: markdown website pdf mobi epub

markdown:
	mkdir -p build/markdown
	awk 'FNR==1{print ""}{print}' 01.\ Started/*.md 02.\ Understand/*.md 03.\ Services/*/*.md  > build/markdown/$(filename).md
	cp -R assets/ build/markdown/assets
	sed -i '' s/\(..\\/assets/\(assets/g build/markdown/$(filename).md
	sed -i '' s/\(..\\/..\\/assets/\(assets/g build/markdown/$(filename).md

website:
	gitbook build --output="build/website"

pdf:
	# gitbook pdf --output="build/pdf/server-sandbox.pdf"
	# You need `pdflatex`
	# OS X: http://www.tug.org/mactex/
	# Then find its path: find /usr/ -name "pdflatex"
	# Then symlink it: ln -s /path/to/pdflatex /usr/local/bin
	mkdir -p build/pdf
	pandoc -s build/markdown/metadata.md build/markdown/$(filename).md -o build/pdf/$(filename).pdf \
		--title-prefix $(title) \
		--normalize \
		--smart \
		--toc \
		-V geometry:margin=1in \
		--latex-engine=`which xelatex`

mobi:
	gitbook mobi --output="build/mobi/server-sandbox.mobi"

epub:
	gitbook epub --output="build/epub/server-sandbox.epub"

gh-pages:
	grunt publish

clean:
	rm -rf build
