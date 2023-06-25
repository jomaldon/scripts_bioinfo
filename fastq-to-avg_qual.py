from Bio import SeqIO
import gzip
import sys

def Average(lst):
        return sum(lst) / len(lst)

file_name = sys.argv[1]

for record in SeqIO.parse(gzip.open(file_name,"rt"), "fastq"):
        print(round(Average(record.letter_annotations["phred_quality"]),1))
