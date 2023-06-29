#!/bin/bash
# Tychele N. Turner, Ph.D.
# Last update: June 28, 2023
# methylation analysis workflow
# These analyses were run on our lambda workstation

1. Generate methylation calls with pb-CpG-tools
```
docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" tychelewustl/test2:egp /home/tychele/Documents/Revio_Testing_N2A/methylation/pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/bin/aligned_bam_to_cpg_scores --bam /data/N2A_Revio/pbmm2/Neuro2a_Revio_SMRTcell1.movie.bam --ref /home/tychele/Data/Reference/mm10.fa --output-prefix /home/tychele/Documents/Revio_Testing_N2A/methylation/Neuro2_Revio_SMRTcell1_A01 --min-mapq 30 --min-coverage 10 --model /home/tychele/Documents/Revio_Testing_N2A/methylation/pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/models/pileup_calling_model.v1.tflite --threads 120

docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" tychelewustl/test2:egp /home/tychele/Documents/Revio_Testing_N2A/methylation/pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/bin/aligned_bam_to_cpg_scores --bam /data/N2A_Revio/pbmm2/Neuro2a_Revio_SMRTcell2.movie.bam --ref /home/tychele/Data/Reference/mm10.fa --output-prefix /home/tychele/Documents/Revio_Testing_N2A/methylation/Neuro2_Revio_SMRTcell2_B01 --min-mapq 30 --min-coverage 10 --model /home/tychele/Documents/Revio_Testing_N2A/methylation/pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/models/pileup_calling_model.v1.tflite --threads 120

docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" tychelewustl/test2:egp /home/tychele/Documents/Revio_Testing_N2A/methylation/pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/bin/aligned_bam_to_cpg_scores --bam /data/N2A_Revio/pbmm2/Neuro2a_Revio_SMRTcell3.movie.bam --ref /home/tychele/Data/Reference/mm10.fa --output-prefix /home/tychele/Documents/Revio_Testing_N2A/methylation/Neuro2_Revio_SMRTcell3_C01 --min-mapq 30 --min-coverage 10 --model /home/tychele/Documents/Revio_Testing_N2A/methylation/pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/models/pileup_calling_model.v1.tflite --threads 120

docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" tychelewustl/test2:egp /home/tychele/Documents/Revio_Testing_N2A/methylation/pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/bin/aligned_bam_to_cpg_scores --bam /data/N2A_Revio/pbmm2/Neuro2a_Revio.final.bam --ref /home/tychele/Data/Reference/mm10.fa --output-prefix /home/tychele/Documents/Revio_Testing_N2A/methylation/Neuro2_Revio_Full_Dataset --min-mapq 30 --min-coverage 10 --model /home/tychele/Documents/Revio_Testing_N2A/methylation/pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/models/pileup_calling_model.v1.tflite --threads 120
```

2. Run post-methylation analyses in R
```
library('data.table')
a01 <- as.data.frame(fread("Neuro2_Revio_SMRTcell1_A01.combined.bed"))
b01 <- as.data.frame(fread("Neuro2_Revio_SMRTcell2_B01.combined.bed"))
c01 <- as.data.frame(fread("Neuro2_Revio_SMRTcell3_C01.combined.bed"))

a01$uniq <- paste(a01$V1, a01$V2, a01$V3, sep="_")
b01$uniq <- paste(b01$V1, b01$V2, b01$V3, sep="_")
c01$uniq <- paste(c01$V1, c01$V2, c01$V3, sep="_")

m <- merge(a01, b01, by="uniq", all=T)
m2 <- merge(m, c01, by="uniq", all=T)

full <- as.data.frame(fread("Neuro2_Revio_Full_Dataset.combined.bed"))
full$uniq <- paste(full$V1, full$V2, full$V3, sep="_")
colnames(full) <- paste("full", colnames(full), sep="_")

m3 <- merge(m2, full, by.x="uniq", by.y="full_uniq", all=T)

#stats
cor.test(m3$V9, m3$V9.x)
cor.test(m3$V9, m3$V9.y)
cor.test(m3$V9, m3$full_V9)

cor.test(m3$V9.x, m3$V9.y)
cor.test(m3$V9.x, m3$full_V9)

cor.test(m3$V9.y, m3$full_V9)
```

