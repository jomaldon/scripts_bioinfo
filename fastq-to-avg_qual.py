#! /usr/bin/env python
#
# @author: Jonathan Maldonado <jomaldon at gmail dot com>
# @update: Jun 24 2023
#
# Biopython required:
# "pip install biopython" or "sudo apt update; sudo apt install biopython" 
#

from Bio import SeqIO
import gzip
import sys

def Average(lst):
        return sum(lst) / len(lst)

file_name = sys.argv[1]

for record in SeqIO.parse(gzip.open(file_name,"rt"), "fastq"):
        print(round(Average(record.letter_annotations["phred_quality"]),1))
