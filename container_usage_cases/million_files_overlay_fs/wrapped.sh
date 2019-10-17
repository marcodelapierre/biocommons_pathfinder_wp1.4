#!/bin/bash
 
mkdir -p $temp_dir
cd $temp_dir
 
echo TIME untar start $(date)
tar xzf $file_in
echo TIME untar end $(date)
 
echo TIME basecall start $(date)
read_fast5_basecaller.py \
    -i 6 -r \
    -s . -o fastq,fast5 \
    --barcoding \
    -f FLO-MIN106 -k SQK-LSK108 \
    -t $OMP_NUM_THREADS
echo TIME basecall end $(date)
 
ls
 
echo TIME tar start $(date)
tar czf $file_out workspace/pass/
echo TIME tar end $(date)
 
echo TIME copy start $(date)
cp -p configuration.cfg sequencing_telemetry.js sequencing_summary.txt pipeline.log $here/
echo TIME copy end $(date)
 
cd $here
rm -r $temp_dir
