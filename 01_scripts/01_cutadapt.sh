#!/bin/bash
# remove adapter sequences from reads using cutadapt
# point to the trimmomatic.jar in Global variables

# Global variables
RAW_FOLDER="02_raw_data"
TRIMMED_FOLDER="03_trimmed"
CUTADAPT="/usr/local/bin/cutadapt"

# Filtering and trimming data with trimmomatic
ls -1 $RAW_FOLDER/*.fastq.gz | \
    perl -pe 's/R[12]\_001.fastq\.gz//' | \
    grep -vE "paired|single" | \
    sort -u | \
    while read i
    do
      echo $i
      $CUTADAPT \
        -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
        -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT \
        -o "$i"R1_001_remadapt.fastq.gz -p "$i"R2_001_remadapt.fastq.gz \
	"$i"R1_001.fastq.gz "$i"R2_001.fastq.gz
    done

#ls -1 $RAW_FOLDER/*R1*.fastq.gz | \
#    sort -u |
#    while read i
#    do
#        echo $i
#	cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -o "${i%fastq.gz}"remadap.fastq.gz "$i"
#    done
#
#ls -1 $RAW_FOLDER/*R2*.fastq.gz | \
#    sort -u |
#    while read i
#    do
#        echo $i
#        cutadapt -a AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o "${i%fastq.gz}"remadap.fastq.gz "$i"
#    done


# Transfer trimmed files to $TRIMMED_FOLDER folder
mv $RAW_FOLDER/*remadapt* $TRIMMED_FOLDER
