#!/bin/bash

qual=10

for i in `cat sample.all.txt`; do ./ab_seq_analyze.dev.sh $i $qual ; done 

./combine_results.sh sample.all.txt $qual

