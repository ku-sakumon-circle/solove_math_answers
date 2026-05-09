#!/bin/bash

home=`pwd`
echo "homedir is "${home}

get_qgroup() {
    q=$((10#$1))
    s=$(( ((q - 1) / 50) * 50 + 1 ))
    e=$(( s + 49 ))
    printf "%03d-%03d" ${s} ${e}
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

qgroup=`get_qgroup ${q}`

if [ ! -d ../problems/part_1/${qgroup}/Q_${q} ] ; then
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
cd ${home}/../problems/part_1/${qgroup}/Q_${q}
fname=`ls -1 Q_${q}.*.tex 2>/dev/null | tail -n 1`
if [ -n "${fname}" ] ; then
    tmp=${fname%.*} ; verq=${tmp#*.}
    target_tex=Q_${q}.${verq}.tex
    echo "Q_${q} ver. is "${verq}
else
    if [ ! -e Q_${q}.tex ] ; then
        echo "ERROR: missing both Q_${q}.*.tex and Q_${q}.tex" ; exit
    fi
    target_tex=Q_${q}.tex
    echo "Q_${q} ver. is current"
fi

cd ${home}

cat <<EOF > 00debug.tex
\documentclass[twocolumn]{jsarticle}

\input{../preamble/preamble.${verp}.tex}

\begin{document}
\fontsize{9pt}{7pt}\selectfont
\lengthparam
\setlength{\columnseprule}{0.5pt}

\input{../problems/part_1/${qgroup}/Q_${q}/${target_tex}}

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
