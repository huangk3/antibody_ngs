#!/bin/bash

sampleList=$1
qual=$2

temp="tmp.results.Q${qual}.txt"
output="combined.results.Q${qual}.txt"

#extract the header row
id=$(cat ${sampleList} |head -n1)

cat $id/${id}.IGH.Q${qual}.txt |grep "best"| awk 'BEGIN{FS="\t"; OFS="\t"} {print "SampleID", "Type", "aaSeqComplete", "nSeqComplete", $0}' > ${temp}

[ ! -d fastQC_reports ] && mkdir fastQC_reports

for sample in `cat $sampleList`; do 
  for t in IGH IGK IGL; do 
    c=$(cat $sample/${sample}.${t}.Q${qual}.txt |wc -l)

    if [[ $c -gt 1 ]]; then
      cat $sample/${sample}.${t}.Q${qual}.txt |grep -v "best" | awk -v s=$sample -v t=$t 'BEGIN{FS="\t"; OFS="\t"} {print s, t, $5$6$7$8$9$10$11,$12$13$14$15$16$17$18,$0}' >> ${temp}
      cp $sample/${sample}_fastqc/*html fastQC_reports/

    fi
  done
done  

add_clone_counts.py -i ${temp} -o ${output}

txt2xlxs.py ${output}

tar -cvzf ab_cdr_results.Q${qual}.tar.gz combined.results.Q${qual}.xlsx fastQC_reports

rm ${temp}
