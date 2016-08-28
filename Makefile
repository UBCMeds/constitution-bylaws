all: constitution-toc.md bylaws-toc.md

clean: 
	rm constitution-toc.md bylaws-toc.md

constitution-toc.md: 1-mus-constitution.md
	cat 1-mus-constitution.md | perl -ne 'if ($$_ =~ /^\#/) {/(\#+)/; $$padding = $$1; $$padding =~ s/#/  /g; $$_ =~ s/\R//g; $$a=$$_; $$a =~ s/#+ +//g; s/\#+ +/\#/g; s/ +/-/g; s/[\(\)*,.&]*//g; print $$padding . "- [$$a](" . lc($$_) . ")\n"}' > constitution-toc.md

bylaws-toc.md: 2-mus-bylaws.md
	cat 2-mus-bylaws.md | perl -ne 'if ($$_ =~ /^\#/) {/(\#+)/; $$padding = $$1; $$padding =~ s/#/  /g; $$_ =~ s/\R//g; $$a=$$_; $$a =~ s/#+ +//g; s/\#+ +/\#/g; s/ +/-/g; s/[\(\)*,.&]*//g; print $$padding . "- [$$a](" . lc($$_) . ")\n"}' > bylaws-toc.md

