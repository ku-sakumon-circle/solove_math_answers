#!/bin/bash

home=`pwd`
echo "homedir is "${home}

qnum=286
echo "total number of problems is "${qnum}

# set preamble
cd ${home}/../problems/preamble
if [ -e preamble.tex ] ; then
    rm -f preamble.tex 
fi

rm -f *~
fname=`ls -1 preamble.*.tex | tail -n 1`
tmp=${fname%.*} ; ver=${tmp#*.}

cp preamble.${ver}.tex preamble.tex
echo "preamble ver. is "${ver}

# for 00NotSolved.txt
cd ${home}
echo "******未完****** " > hoge.txt
echo "*****未着手***** " > fuga.txt
echo "******欠番****** " > piyo.txt

# set problems
for q in `seq -w 1 ${qnum}`
do
#    break
    cd ${home}/../problems/Q_${q}
    if [ -e Q_${q}.tex ] ; then
	rm -f Q_${q}.tex
    fi

    rm -f *~
    fname=`ls -1 Q_${q}.*.tex | tail -n 1`
    tmp=${fname%.*} ; ver=${tmp#*.}

    cp Q_${q}.${ver}.tex Q_${q}.tex
    echo "Q_${q} ver. is "${ver}

    grep けつばん ${fname} > /dev/null
    if [ "$?" -eq 0 ] ; then
	echo "Q_${q} " >> ${home}/piyo.txt
    fi
    grep 未完 ${fname} > /dev/null
    if [ "$?" -eq 0 ] ; then
	echo "Q_${q} " >> ${home}/hoge.txt
    else
	grep ここに解答を記述 ${fname} > /dev/null
	if [ "$?" -eq 0 ] ; then
	    echo "Q_${q} " >> ${home}/fuga.txt
	fi
    fi
done

cd ${home}
cat hoge.txt fuga.txt piyo.txt > 00NotSolved.txt
rm hoge.txt ; rm fuga.txt ; rm piyo.txt

rm 00main.idx

platex 00main.tex
if [ $? -ne 0 ] ; then
    echo "platex 1st ERROR" ; exit
fi

mendex -s 00main.ist 00main.idx
if [ $? -ne 0 ] ; then
    echo "mendex ERROR" ; exit
fi

platex 00main.tex
if [ $? -ne 0 ] ; then
    echo "platex 2nd ERROR" ; exit
fi

dvipdfmx 00main.dvi
if [ $? -ne 0 ] ; then
    echo "dvipdfmx ERROR" ; exit
fi

rm -f 00main.aux 00main.dvi 00main.ind 00main.idx 00main.ilg
rm -f *~
