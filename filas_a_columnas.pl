#!/usr/bin/perl
# filas_a_columnas.pl
# Jonathan Maldonado
# ultima version: Junio 2019

# Transforma un archivo que tiene en la primera columna un ID y en la segunda columna un GO en un archivo que tiene en la primera columna un ID y todos los GO que le corresponden estarán en las columnas a la derecha (la información de los GO queda condensada en una fila).
# El ID pasará a ser un objeto único. Habrán tantas filas como IDs únicos.

# El archivo de entrada debe estar separado por "tab"
# El archivo de entrada debe estar "ordenado" (sort entrada.txt > entrada.sort.txt)
# El archivo de salida estará separado por "tab" y los GOs por ";"
# El archivo de salida estará ordenado por ID

# Uso:
# filas_a_columnas.pl entrada.sort.txt > salida.txt

# entrada.sort.txt tiene dos columnas / salida.txt tendrá múltiples columnas

use strict;

my $in_file = $ARGV[0];

open INFILE, $in_file or die "no pude abrir $in_file";

my $lastkey="";

#print "ID\tannot";
my $first=1;

while(<INFILE>){
  chomp;
  s/^ +//;
  s/\t/\|/; # reemplazo tab por pipe

  my ($key,$word) = split(/\|/);
#  print "$key-$word\n";

  if($lastkey eq $key){
	print ";$word";
  }
  else{
	if($first){
		print "$key\t$word";
		$lastkey=$key;
		$first=0;
	}
	else{
		print "\n";
		print "$key\t$word";
		$lastkey=$key;
	}
  }
}
print "\n";

close INFILE;
