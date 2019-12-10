#!/usr/bin/perl

# linealarga.pl
# Nicolas Loira
# github: nloira
# ultima version: mayo 2005
# (corregido bug de primera linea)
# (en caso de no dar archivo de salida, arroja al stdout)

# Transforma un archivo de secuencias en formato fasta con ancho maximo de columna
# en uno con una fila por secuencia. Util cuando se desea buscar patrones.

# Uso: 
# linealarga.pl fasta.seq fasta.linealarga.seq
# o tambien:
# linealarga.pl fasta.seq > fasta.linealarga.seq

open INFILE, "$ARGV[0]";

if($#ARGV==0){
	open OUTFILE, ">&STDOUT";
}else{
	open OUTFILE, ">$ARGV[1]";
}

$buffer = "";

while (<INFILE>){

	if( />/ ){
		$buffer =~ tr/atgcn/ATGCN/;
		if($buffer ne ""){
			print OUTFILE $buffer."\n".$_;
		}else{
			print OUTFILE $_;
		}

		$buffer ="";
	}
	else{
		chomp($_);
		$buffer .= $_;
	}
}

$buffer =~ tr/atgcn/ATGCN/;
print OUTFILE $buffer."\n";

close INFILE;
close OUTFILE;

