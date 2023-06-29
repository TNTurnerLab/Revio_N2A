#!/bin/bash
# Tychele N. Turner, Ph.D.
# Last update: June 28, 2023
# Post Hifiasm Assessment

#get fasta from gfa
for i in *ctg.gfa
do
/gfatools/gfatools gfa2fa "$i" > "$i".ctg.fasta
done

#get stats from fasta
for i in *.ctg.fasta
do
/opt/conda/bin/k8 calN50/calN50.js -f /path/to/mouse/reference/mm10.fa.fai "$i" > "$i".stats.txt
done

