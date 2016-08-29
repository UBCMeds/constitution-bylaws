.PHONY: all pdf clean

all: 1-mus-constitution.md 2-mus-bylaws.md

pdf: tex 1-mus-constitution.pdf 2-mus-bylaws.pdf 3-mus-appendix.pdf

clean: 
	rm markdown/constitution-toc.md markdown/bylaws-toc.md 1-mus-constitution.md 2-mus-bylaws.md tex/* ./*.pdf

tidy:
	rm markdown/constitution-toc.md markdown/bylaws-toc.md tex/*

tex:
	mkdir -p tex


1-mus-constitution.pdf: tex/1-mus-constitution.pdf
	cp tex/1-mus-constitution.pdf 1-mus-constitution.pdf

2-mus-bylaws.pdf: tex/2-mus-bylaws.pdf
	cp tex/2-mus-bylaws.pdf 2-mus-bylaws.pdf

3-mus-appendix.pdf: tex/3-mus-appendix.pdf
	cp tex/3-mus-appendix.pdf 3-mus-appendix.pdf


tex/3-mus-appendix.pdf: tex/3-mus-appendix.tex
	pdflatex -output-directory=tex tex/3-mus-appendix.tex

tex/3-mus-appendix.tex: 3-mus-appendix.md
	pandoc --from markdown --to latex --standalone --output tex/3-mus-appendix.tex 3-mus-appendix.md


tex/2-mus-bylaws.pdf: tex/2-mus-bylaws.tex
	pdflatex -output-directory=tex tex/2-mus-bylaws.tex; pdflatex -output-directory=tex tex/2-mus-bylaws.tex

tex/2-mus-bylaws.md: markdown/bylaws-header.md markdown/bylaws-content.md
	cat markdown/bylaws-header.md markdown/bylaws-content.md > tex/2-mus-bylaws.md

tex/2-mus-bylaws.tex: tex/2-mus-bylaws.md
	pandoc --from markdown --to latex --toc --standalone --output tex/2-mus-bylaws.tex tex/2-mus-bylaws.md


tex/1-mus-constitution.pdf: tex/1-mus-constitution.tex
	pdflatex -output-directory=tex tex/1-mus-constitution.tex; pdflatex -output-directory=tex tex/1-mus-constitution.tex

tex/1-mus-constitution.md: markdown/constitution-header.md markdown/constitution-content.md
	cat markdown/constitution-header.md markdown/constitution-content.md > tex/1-mus-constitution.md

tex/1-mus-constitution.tex: tex/1-mus-constitution.md
	pandoc --from markdown --to latex --toc --standalone --output tex/1-mus-constitution.tex tex/1-mus-constitution.md


1-mus-constitution.md: markdown/constitution-header.md markdown/constitution-toc.md markdown/constitution-content.md
	awk 'FNR==1{print ""}1' markdown/constitution-header.md markdown/constitution-toc.md markdown/constitution-content.md > 1-mus-constitution.md

2-mus-bylaws.md: markdown/bylaws-header.md markdown/bylaws-toc.md markdown/bylaws-content.md
	awk 'FNR==1{print ""}1' markdown/bylaws-header.md markdown/bylaws-toc.md markdown/bylaws-content.md > 2-mus-bylaws.md

markdown/constitution-toc.md: markdown/constitution-content.md
	cat markdown/constitution-content.md | perl -ne 'if ($$_ =~ /^\#/) {/(\#+)/; $$padding = $$1; $$padding =~ s/##//; $$padding =~ s/#/  /g; $$_ =~ s/\R//g; $$a=$$_; $$a =~ s/#+ +//g; s/\#+ +/\#/g; s/ +/-/g; s/[\(\)*,.&]*//g; print $$padding . "- [$$a](" . lc($$_) . ")\n"}' > markdown/constitution-toc.md

markdown/bylaws-toc.md: markdown/bylaws-content.md
	cat markdown/bylaws-content.md | perl -ne 'if ($$_ =~ /^\#/) {/(\#+)/; $$padding = $$1; $$padding =~ s/##//; $$padding =~ s/#/  /g; $$_ =~ s/\R//g; $$a=$$_; $$a =~ s/#+ +//g; s/\#+ +/\#/g; s/ +/-/g; s/[\(\)*,.&]*//g; print $$padding . "- [$$a](" . lc($$_) . ")\n"}' > markdown/bylaws-toc.md
