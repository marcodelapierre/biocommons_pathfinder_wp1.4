#!/bin/bash

if [ $# -eq 0 ] ; then
 echo "Provide container runtime as argument: docker or singularity"
 exit
fi
runtime="$1"
if [ "$runtime" == "docker" ] ; then
 exe="docker pull "
elif [ "$runtime" == "singularity" ] ; then
 exe="singularity pull docker://"
else
 echo "Container runtime not supported: choose docker or singularity"
 exit
fi

packages="
quay.io/biocontainers/quast:5.0.2--py35pl526ha92aebf_0
quay.io/biocontainers/busco:3.0.2--py37_12
quay.io/biocontainers/rsem:1.3.2--pl526r351hc0aa232_0
quay.io/biocontainers/trinotate:3.2.0--pl526_0
quay.io/biocontainers/maker:2.31.10--pl526_14
quay.io/biocontainers/trinity:2.8.5--h8b12597_5
marcodelapierre/supernova:2.1.1
marcodelapierre/juicer:27Aug19-cpu
"

for p in $packages ; do
 echo ""
 echo "Pulling package " $p ".."
 echo "$exe$p"
done

exit

