#!/bin/bash
# This script is used to find genes that exist within both files.
# The arguments used in this script are:
# {1}= the genes found in an analysis, this is csv where the second column contains the genes of interest
# {2}= the file containing the variants
#
# The found lines are written to standard output

found_genes=${1}
variant_file=${2}

awk -F "," '{print $2}' ${found_genes} | while read -r gene_symbol; 
do
# Grep the lines, remove empty lines, and replace space from found line with a new line
  echo $(grep ",${gene_symbol}," ${variant_file}) | awk NF | tr " " "\n"
done
