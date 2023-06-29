#!/bin/bash
# Tychele N. Turner, Ph.D.
# Last update: June 28, 2023
# HiCanu

export PATH=/opt/conda/bin:$PATH

SAMPLE='Neuro2a_Revio'

canu -p "$SAMPLE"_hicanu_assembly -d "$SAMPLE"_hicanu_assembly maxThreads=62 maxMemory=2700 genomeSize=3g useGrid=false -pacbio-hifi /path/to/fastq/XTTWU_20230426_R84050_PL100293497-1_A01.default.fastq.gz /path/to/fastq/XTTWU_20230426_R84050_PL100293497-1_B01.default.fastq.gz /path/to/fastq/XTTWU_20230426_R84050_PL100293497-1_C01.default.fastq.gz

