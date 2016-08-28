bylaws-toc.md: 2-mus-bylaws.md
	cat 2-mus-bylaws.md | perl -ne 'if ($$_ =~ /^\#/) {/(\#+)/; $$padding = $$1; $$padding =~ s/#/  /g; $$_ =~ s/\R//g; $$a=$$_; $$a =~ s/#+ +//g; s/\#+ +/\#/g; s/ +/-/g; s/[\(\)*,.&]*//g; print $$padding . "- [$$a](" . lc($$_) . ")\n"}' > bylaws-toc.md
