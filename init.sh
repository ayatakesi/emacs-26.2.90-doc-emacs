#!/bin/sh

for orig in original_texis/*.texi
do
    orig_base=$(basename ${orig})
    old_po=../emacs-26.2-doc-emacs/${orig_base}.po
    if [ -e ${old_po} ];
    then
	po4a-gettextize -M utf8 \
		    -f texinfo \
		    -m ${orig} \
		    -p ${orig_base}.pot
	
	msgmerge --previous \
		 --no-wrap \
		 --compendium /dev/null \
		 -o ${orig_base}.po \
		 ${old_po} ${orig_base}.pot

    else
	rm -f $orig_base
	cp -p $orig .
    fi
done
