#!/bin/bash

home=`pwd`
echo "homedir is "${home}

get_qgroup() {
    q=$((10#$1))
    s=$(( ((q - 1) / 50) * 50 + 1 ))
    e=$(( s + 49 ))
    printf "%03d-%03d" ${s} ${e}
}

get_problem_dir() {
    q=$((10#$1))
    case ${q} in
        250) echo "../problems/part_2/Q_2_6" ;;
        256) echo "../problems/part_2/Q_2_4" ;;
        259) echo "../problems/part_2/Q_2_5" ;;
        266) echo "../problems/part_2/Q_2_3" ;;
        267) echo "../problems/part_2/Q_2_2" ;;
        268) echo "../problems/part_2/Q_2_1" ;;
        *)
            qgroup=`get_qgroup $1`
            echo "../problems/part_1/${qgroup}/Q_$1"
            ;;
    esac
}

get_problem_base() {
    q=$((10#$1))
    case ${q} in
        250) echo "Q_2_6" ;;
        256) echo "Q_2_4" ;;
        259) echo "Q_2_5" ;;
        266) echo "Q_2_3" ;;
        267) echo "Q_2_2" ;;
        268) echo "Q_2_1" ;;
        *) echo "Q_$1" ;;
    esac
}

qnum=$(sed -n 's/^\\providecommand{\\SMMaxProblemNumber}{\([0-9][0-9]*\)}$/\1/p' ../config/config.tex | tr -d '\r' | tail -n 1)
if [ -z "${qnum}" ] ; then
    echo "ERROR: failed to read SMMaxProblemNumber from config/config.tex" ; exit
fi
echo "total number of problems is "${qnum}

# set preamble
cd ${home}/../preamble
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
    qdir=`get_problem_dir ${q}`
    qbase=`get_problem_base ${q}`
    cd ${home}/${qdir}

    rm -f *~
    fname=`ls -1 ${qbase}.*.tex 2>/dev/null | tail -n 1`
    if [ -n "${fname}" ] ; then
	tmp=${fname%.*} ; ver=${tmp#*.}
    cp ${qbase}.${ver}.tex ${qbase}.tex
    echo "${qbase} ver. is "${ver}
    else
    if [ ! -e ${qbase}.tex ] ; then
        echo "ERROR: missing both ${qbase}.*.tex and ${qbase}.tex" ; exit
	fi
    fname=${qbase}.tex
    echo "${qbase} ver. is current"
    fi

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
rm -f 00main.aux 00main.out 00main.toc 00main.ind 00main.ilg

platex 00main.tex
if [ $? -ne 0 ] ; then
    echo "platex 1st ERROR" ; exit
fi

if [ -e 00main.ist ] ; then
    mendex -s 00main.ist 00main.idx
else
    mendex 00main.idx
fi
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
