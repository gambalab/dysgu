
FROM python:3.11

MAINTAINER Kez Cleal clealk@cardiff.ac.uk

USER root

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip install dysgu==1.6.6 && \
wget https://github.com/samtools/samtools/releases/download/1.20/samtools-1.20.tar.bz2 && \
tar -xvf samtools-1.20.tar.bz2 && \
rm samtools-1.20.tar.bz2 && \
mv samtools-1.20 samtools && \
cd samtools && ./configure && \
make -j4 && \
make install && \
cd ../ && \
wget https://github.com/samtools/bcftools/releases/download/1.20/bcftools-1.20.tar.bz2 && \
tar -xvf bcftools-1.20.tar.bz2 && \
rm bcftools-1.20.tar.bz2 && \
mv bcftools-1.20 bcftools && \
cd bcftools && \
./configure && \
make -j4 && \
make install && \
cd ../

CMD ["/bin/sh"]


# Docker user guide
# -----------------
## Make an 'input_folder', put your bam file and reference genome inside:

# ./input_folder/
#     sample.bam
#     reference.fasta
#     reference.fasta.fai

## Make an 'output_folder'
# mkdir output_folder

## Set up docker
# docker pull kcleal/dysgu
# docker run -it \
#      --mount src="${PWD}"/input_folder,target=/input_folder,type=bind \
#      --mount src="${PWD}"/output_folder,target=/output_folder,type=bind \
#      kcleal/dysgu
# cd input_folder

## Run dysgu:

# dysgu run reference.fasta wd sample.bam > ../output_folder/sample.vcf
# exit
