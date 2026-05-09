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

default_q=$(sed -n 's/^\\providecommand{\\SMDefaultDebugProblemNumber}{\([0-9][0-9]*\)}$/\1/p' ../config/config.tex | tr -d '\r' | tail -n 1)
if [ -z "${default_q}" ] ; then
    echo "ERROR: failed to read SMDefaultDebugProblemNumber from config/config.tex" ; exit
fi

if [ $# -eq 0 ] ; then
    q=${default_q}
elif [ $# -eq 1 ] ; then
    q=${1}
else
    echo "ERROR: at most 1 argument needed" ; exit
fi

qdir=`get_problem_dir ${q}`
qbase=`get_problem_base ${q}`

if [ ! -d ${qdir} ] ; then
    echo "ERROR: not exist problems number" ; exit
else
    echo "debug mode : problem number is "${q}
fi

# set preamble
cd ${home}/../preamble
fname=`ls -1 preamble.*.tex | tail -n 1`
tmp=${fname%.*} ; verp=${tmp#*.}
echo "preamble ver. is "${verp}
rm -f ${fname}~

# set problems
cd ${home}/${qdir}
fname=`ls -1 ${qbase}.*.tex 2>/dev/null | tail -n 1`
if [ -n "${fname}" ] ; then
    tmp=${fname%.*} ; verq=${tmp#*.}
    target_tex=${qbase}.${verq}.tex
    echo "${qbase} ver. is "${verq}
else
    if [ ! -e ${qbase}.tex ] ; then
        echo "ERROR: missing both ${qbase}.*.tex and ${qbase}.tex" ; exit
    fi
    target_tex=${qbase}.tex
    echo "${qbase} ver. is current"
fi

cd ${home}

cat <<EOF > 00debug.tex
\documentclass[twocolumn]{jsarticle}

\input{../preamble/preamble.${verp}.tex}

\begin{document}
\fontsize{9pt}{7pt}\selectfont
\lengthparam
\setlength{\columnseprule}{0.5pt}

\input{${qdir}/${target_tex}}

\end{document}

EOF

platex 00debug.tex
if [ $? -ne 0 ] ; then
    echo "platex ERROR" ; exit
fi

dvipdfmx 00debug.dvi
if [ $? -ne 0 ] ; then
    echo "dvipdfmx ERROR" ; exit
fi

rm -f 00debug.aux 00debug.dvi 00debug.idx
