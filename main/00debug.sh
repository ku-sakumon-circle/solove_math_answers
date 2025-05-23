#!/bin/bash

home=`pwd`
echo "homedir is "${home}

if [ $# -ne 1 ] ; then
    echo "ERROR: only 1 argument needed" ; exit
elif [ ! -d ../problems/Q_${1} ] ; then
    echo "ERROR: not exist problems number" ; exit
else
    echo "debug mode : problem number is "${1}
fi

# set preamble
cd ${home}/../problems/preamble
fname=`ls -1 preamble.*.tex | tail -n 1`
tmp=${fname%.*} ; verp=${tmp#*.}
echo "preamble ver. is "${verp}
rm -f ${fname}~

# set problems
cd ${home}/../problems/Q_${1}
fname=`ls -1 Q_${1}.*.tex | tail -n 1`
tmp=${fname%.*} ; verq=${tmp#*.}
echo "Q_${1} ver. is "${verq}

cd ${home}

cat <<EOF > 00debug.tex
\documentclass[twocolumn]{jsarticle}

\input{../problems/preamble/preamble.${verp}.tex}

\begin{document}
\fontsize{9pt}{7pt}\selectfont
\lengthparam
\setlength{\columnseprule}{0.5pt}

\input{../problems/Q_${1}/Q_${1}.${verq}.tex}

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
