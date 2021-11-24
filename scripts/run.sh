#!/bin/bash

qual=10

#for i in `ls *.fastq.gz`; do s=$(echo $i |cut -d_ -f1|sort |uniq); echo -e "$s"; done > sample.all.txt

for i in `cat sample.all.txt`; do ./ab_seq_analyze.dev.sh $i $qual ; done 

./combine_results.sh sample.all.txt $qual

