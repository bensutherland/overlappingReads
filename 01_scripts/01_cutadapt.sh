#!/bin/bash
# remove adapter sequences from reads using cutadapt
# point to the trimmomatic.jar in Global variables

# Global variables
RAW_FOLDER="02_raw_data"
ADREM_FOLDER="03_adapter_removed"
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
	"$i"R1_001.fastq.gz "$i"R2_001.fastq.gz \
        --minimum-length 2
    done

# Transfer trimmed files to $ADREM_FOLDER folder
mv $RAW_FOLDER/*remadapt* $ADREM_FOLDER
