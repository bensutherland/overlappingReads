#!/bin/bash
#$ -N PEAR
#$ -M $MY_EMAIL_ADDRESS
#$ -m beas
#$ -pe smp 3
#$ -l h_vmem=40G
#$ -l h_rt=24:00:00
#$ -cwd
#$ -S /bin/bash

time ./01_scripts/02_PEAR.sh
