#!/bin/bash

# Uses the program FLASh to merge overlapping paired-end reads to produce single contigs of a greater length
# default overlap is 10 bp

# from FLASH website http://ccb.jhu.edu/software/FLASH/
# "Merging mate pairs by FLASH as a pre-processor for genome assembly yields singificantly higher N50 value of contigs and scaffolds. It also reduces the number of missassembled contigs."
# FLASH is not designed for data with significant indel error, it is best suited for Illumina (see README for more information)
# gzip compressed input is autodetected

# Global variables
ADREM_FOLDER="03_adapter_removed"
BINNED_FOLDER="04_binned_pairs"
FLASH="/project/lbernatchez/drobo/users/bensuth/programs/FLASH-1.2.11/flash"

## Filtering and trimming data with trimmomatic
ls -1 $ADREM_FOLDER/*.fastq.gz | 
    perl -pe 's/R[12]\.remadapt.fastq\.gz//' | 
    sort -u | 
    while read i
    do
      echo $i 
      prefix=$(basename $i) 
      $FLASH "$i"R1.remadapt.fastq.gz "$i"R2.remadapt.fastq.gz --compress --output-directory=$BINNED_FOLDER -t 5 --output-prefix="$prefix"
    done


## move output QC files to folder output_histograms/
mv 04_binned_pairs/*.hist* 04_binned_pairs/output_histograms/
