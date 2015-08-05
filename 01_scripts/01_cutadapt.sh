#!/bin/bash
# remove adapter sequences from reads using cutadapt

# Global variables
RAW_FOLDER="02_raw_data"
REMADAPT_FOLDER="03_adapter_removed"
CUTADAPT="/usr/local/bin/cutadapt"
ADAPTER_FWD="AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC"
ADAPTER_REV="AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT"

# remove adapters with cutadapt
ls -1 $RAW_FOLDER/*.fastq.gz | \
    grep -vE "paired|single" | \
    perl -pe 's/R[12]\.fastq\.gz//' | \
    sort -u | \
    while read i
    do
      echo $i
      $CUTADAPT \
        -a $ADAPTER_FWD \
        -A $ADAPTER_REV \
        -o "$i"R1.remadapt.fastq.gz -p "$i"R2.remadapt.fastq.gz \
	"$i"R1.fastq.gz "$i"R2.fastq.gz \
        --minimum-length 100 \
        -e 0.2
    done

# Transfer trimmed files to $ADREM_FOLDER folder
mv $RAW_FOLDER/*remadapt* $REMADAPT_FOLDER
