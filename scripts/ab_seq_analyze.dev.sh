#!/bin/bash

sample=$1
qual=$2

PRESET="/home/kh/resource/files/mixCR.preset.txt"


[ ! -d $sample ] && mkdir $sample
cd $sample

#option out the "--trimming-quality-threshold 20"
mixcr align -f --report ${sample}.Q${qual}.align.report -t 4 --library imgt -s HomoSapiens --trimming-quality-threshold $qual -p rna-seq ../${sample}_combined_R1.fastq.gz ../${sample}_combined_R2.fastq.gz ${sample}.Q${qual}.vdjca

mkdir ${sample}_fastqc 

fastqc -o ${sample}_fastqc -t 4 ../${sample}_combined_R1.fastq.gz ../${sample}_combined_R2.fastq.gz

mixcr assemble -f -OassemblingFeatures="[FR1,CDR1,FR2,CDR2,FR3,CDR3,FR4]" ${sample}.Q${qual}.vdjca ${sample}.Q${qual}.clns


for i in IGH IGK IGL; do 
  mixcr exportClones -f -vHit -jHit -vAlignment -jAlignment \
	 -aaFeature FR1 -nFeature FR1 \
	 -aaFeature CDR1 -nFeature CDR1 \
	 -aaFeature FR2 -nFeature FR2 \
         -aaFeature CDR2 -nFeature CDR2 \
         -aaFeature FR3 -nFeature FR3 \
         -aaFeature CDR3 -nFeature CDR3 \
         -aaFeature FR4 -nFeature FR4 \
	 -count -fraction\
	 -c $i ${sample}.Q${qual}.clns ${sample}.${i}.Q${qual}.txt
 
# mixcr exportClones -f --preset-file $PRESET\
#	 -c $i ${sample}.Q${qual}.clns ${sample}.${i}.Q${qual}.txt
done

cd ..
