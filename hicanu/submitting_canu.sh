#!/bin/bash
# Tychele N. Turner, Ph.D.
# Last update: June 28, 2023
# HiCanu analysis workflow

bsub -R 'span[hosts=1] rusage[mem=2800G]' -g /tychele/dv -n 62 -M 2800G -q tychele -G compute-tychele -oo Neuro2a_Revio_hicanu.oo -a "docker(tychelewustl/canu:2.2)" sh running_canu.sh

