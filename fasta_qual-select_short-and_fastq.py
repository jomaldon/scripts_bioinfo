#! /usr/bin/env python
#
# @author: Jonathan Maldonado <jomaldon at gmail dot com>
# @update: Nov 07 2021
#
# Biopython required:
# pip install biopython

import sys, getopt, os
from Bio import SeqIO

#print('Number of arguments: {}'.format(len(sys.argv)))
#print('Argument(s) passed: {}'.format(str(sys.argv)))
#print(sys.argv[1])

# Get the arguments from the command-line except the filename
argv = sys.argv[1:]
fasta  = ''
qual = ''
fastq = ''
try:
    opts, args = getopt.getopt(argv, 'f:q:o:', ['ifasta=', 'iqual=','ofastq='])
    if len(opts) != 3:
        print ('usage: fasta_qual-select_short-and_fastq2.py -f <input_fasta> -q <input_qual> -o <output_fastq>')
        sys.exit(2)
    else:
        for opt, arg in opts:
            if opt in ("-f", "--ifasta"):
                fasta = arg
            elif opt in ("-q", "--iqual"):
                qual = arg
            elif opt in ("-o", "--ofastq"):
                fastq = arg
        if(not os.path.exists(fasta)):
            print ('No such file:', fasta)
            sys.exit(2)
        elif(not os.path.exists(qual)):
            print ('No such file:', qual)
            sys.exit(2)
        print ("Fasta file is :", fasta)
        print ("Qual file is :", qual)
        print ("Fastq will be :", fastq)
except getopt.GetoptError:
    print ('usage: fasta_qual-select_short-and_fastq2.py -f <input_fasta> -q <input_qual> -o <output_fastq>')
    sys.exit(2)

f = open(fastq, "w")

reads = SeqIO.to_dict(SeqIO.parse(fasta, "fasta"))
for rec in SeqIO.parse(qual, "qual"):
    readlen=len(reads[rec.id].seq)
    quallen=len(rec.seq)
    if(readlen<=quallen):
        sub_rec = rec[0:int(readlen)]
        reads[rec.id].letter_annotations["phred_quality"]=sub_rec.letter_annotations["phred_quality"]
    else:
        sub_read = reads[rec.id][0:int(quallen)]
        reads[rec.id]=sub_read
        reads[rec.id].letter_annotations["phred_quality"]=rec.letter_annotations["phred_quality"]
    f.write(reads[rec.id].format("fastq"))

f.close()

print ('Done!')
