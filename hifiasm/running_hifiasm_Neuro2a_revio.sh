#!/bin/bash
# Tychele N. Turner, Ph.D.
# Last update: June 28, 2023

export PATH=/opt/conda/bin:$PATH

hifiasm -o Neuro2a_Revio.asm -t100 /path/to/fastq/XTTWU_20230426_R84050_PL100293497-1_A01.default.fastq.gz /path/to/fastq/XTTWU_20230426_R84050_PL100293497-1_B01.default.fastq.gz /path/to/fastq/XTTWU_20230426_R84050_PL100293497-1_C01.default.fastq.gz

