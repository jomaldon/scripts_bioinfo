## Need Biopython

from Bio import SeqIO

import sys

arch = sys.argv[1]
print("Reading:"+arch)
arch = arch.replace(".fastq","")
arch = arch.replace(".fq","")
arch = arch.replace(".FASTQ","")
arch = arch.replace(".FQ","")
print("Basename:"+arch)

records = SeqIO.parse(arch+".fastq", "fastq")
seq = SeqIO.write(records, arch+".fasta", "fasta")

records = SeqIO.parse(arch+".fastq", "fastq")
count = SeqIO.write(records, arch+".qual", "qual")

print("Converted %i records" % count)


