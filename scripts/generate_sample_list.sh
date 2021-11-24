#!/bin/bash 

#workdir=$1

grep -A 10000 "^Sample_ID" ../SampleSheetUsed.csv |tail -n+2 |cut -f1 -d, |sed 's/-/_/g' > sample.all.txt

ls *fastq.gz > fastq.list
