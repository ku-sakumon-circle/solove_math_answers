#!/bin/bash

set -e

platex 00main.tex

if [ -s 00main.idx ]; then
	mendex 00main.idx || true
else
	: > 00main.ind
fi

platex 00main.tex
dvipdfmx 00main.dvi

rm -f 00main.aux 00main.dvi 00main.ind 00main.idx 00main.ilg 00main.log 00main.toc 00main.out
