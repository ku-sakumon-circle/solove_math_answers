#!/bin/bash

home=`pwd`

for q in `seq 10 99`
do
    cd ${home}/Q_0${q}

    ver=000000
    for fname in `ls -1 Q_0${q}.*.tex`
    do
	a=${fname%.*} ; tmp=${a#*.}
	if [ ${tmp} -gt ${ver} ] ; then
	    ver=${tmp}
	fi
    done
    echo ${q}/${ver}

    sed -n s/{${q}}/{0${q}}/p Q_0${q}.${ver}.tex
    sed s/{${q}}/{0${q}}/ Q_0${q}.${ver}.tex > hoge
    #    sed s/{${q}}/{0${q}}/ Q_0${q}.${ver}.tex > Q_0${q}.${ver}.tex
    mv hoge Q_0${q}.${ver}.tex
done
