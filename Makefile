all: website pdf mobi epub

website:
	gitbook build --output="build/website"

pdf:
	gitbook pdf --output="build/pdf/server-for-dummies.pdf"

mobi:
	gitbook mobi --output="build/mobi/server-for-dummies.mobi"

epub:
	gitbook epub --output="build/epub/server-for-dummies.epub"

gh-pages:
	grunt publish

clean:
	rm -rf build
