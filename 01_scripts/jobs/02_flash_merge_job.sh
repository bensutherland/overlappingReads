#!/bin/bash
#$ -N FLASH
#$ -M $MY_EMAIL_ADDRESS
#$ -m beas
#$ -pe smp 5
#$ -l h_vmem=20G
#$ -l h_rt=48:00:00
#$ -cwd
#$ -S /bin/bash

time ./01_scripts/02_flash_merge.sh
