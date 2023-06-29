#!/bin/bash
# Tychele N. Turner, Ph.D.
# Last update: June 28, 2023
# NVIDIA Parabricks DeepVariant analysis workflow
# These analyses were run on our lambda workstation

1. Run NVIDIA Parabricks DeepVariant
#for full pacbio data
```
docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" --gpus all nvcr.io/nvidia/clara/clara-parabricks:4.1.0-1 pbrun deepvariant --ref /home/tychele/Data/Reference/mm10.fa --in-bam /data/N2A_Revio/pbmm2/Neuro2a_Revio.final.bam --out-variants /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_Full_Dataset_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf --mode pacbio
```

#for SMRT cell A01
```
docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" --gpus all nvcr.io/nvidia/clara/clara-parabricks:4.1.0-1 pbrun deepvariant --ref /home/tychele/Data/Reference/mm10.fa --in-bam /data/N2A_Revio/pbmm2/Neuro2a_Revio_SMRTcell1.movie.bam --out-variants /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_SMRTcell1_A01_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf --mode pacbio
```

#for SMRT cell B01
```
docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" --gpus all nvcr.io/nvidia/clara/clara-parabricks:4.1.0-1 pbrun deepvariant --ref /home/tychele/Data/Reference/mm10.fa --in-bam /data/N2A_Revio/pbmm2/Neuro2a_Revio_SMRTcell2.movie.bam --out-variants /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_SMRTcell2_B01_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf --mode pacbio
```

#for SMRT cell C01
```
docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" --gpus all nvcr.io/nvidia/clara/clara-parabricks:4.1.0-1 pbrun deepvariant --ref /home/tychele/Data/Reference/mm10.fa --in-bam /data/N2A_Revio/pbmm2/Neuro2a_Revio_SMRTcell3.movie.bam --out-variants /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_SMRTcell3_C01_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf --mode pacbio
```

2. bgzip and index the vcfs
```
for i in *vcf ; do docker run -v "/home/tychele/:/home/tychele/" tychelewustl/test2:cbs /opt/conda/bin/bgzip /home/tychele/Documents/Revio_Testing_N2A/"$i"; done
for i in *vcf.gz ; do sudo docker run -v "/home/tychele/:/home/tychele/" tychelewustl/test2:cbs /opt/conda/bin/tabix -p vcf /home/tychele/Documents/Revio_Testing_N2A/"$i" ; done
```

3. Run bcftools stats
```
docker run -v "/home/tychele/:/home/tychele/" tychelewustl/test2:cbs /opt/conda/bin/bcftools stats /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_Full_Dataset_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf.gz > /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_Full_Dataset_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf.bcftools.stats.txt

docker run -v "/home/tychele/:/home/tychele/" tychelewustl/test2:cbs /opt/conda/bin/bcftools stats /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_SMRTcell1_A01_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf.gz > /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_SMRTcell1_A01_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf.bcftools.stats.txt

docker run -v "/home/tychele/:/home/tychele/" tychelewustl/test2:cbs /opt/conda/bin/bcftools stats /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_SMRTcell2_B01_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf.gz > /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_SMRTcell2_B01_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf.bcftools.stats.txt

docker run -v "/home/tychele/:/home/tychele/" tychelewustl/test2:cbs /opt/conda/bin/bcftools stats /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_SMRTcell3_C01_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf.gz > /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_SMRTcell3_C01_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf.bcftools.stats.txt
```

4. Run concordance checks of each SMRT cell against full
docker run -v "/home/tychele/:/home/tychele/" tychelewustl/test2:cbs /opt/conda/bin/bcftools gtcheck -a -g /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_Full_Dataset_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf.gz /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_SMRTcell1_A01_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf.gz --GTs-only 1 | tail -2 > /home/tychele/Documents/Revio_Testing_N2A/comparison_of_full_dataset_and_A01.txt

docker run -v "/home/tychele/:/home/tychele/" tychelewustl/test2:cbs /opt/conda/bin/bcftools gtcheck -a -g /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_Full_Dataset_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf.gz /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_SMRTcell2_B01_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf.gz --GTs-only 1 | tail -2 > /home/tychele/Documents/Revio_Testing_N2A/comparison_of_full_dataset_and_B01.txt

docker run -v "/home/tychele/:/home/tychele/" tychelewustl/test2:cbs /opt/conda/bin/bcftools gtcheck -a -g /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_Full_Dataset_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf.gz /home/tychele/Documents/Revio_Testing_N2A/Neuro2a_SMRTcell3_C01_PacBio_WGS.deepvariant.Ada.6000.GPU.05162023.vcf.gz --GTs-only 1 | tail -2 > /home/tychele/Documents/Revio_Testing_N2A/comparison_of_full_dataset_and_C01.txt
```

