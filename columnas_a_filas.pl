#!/usr/bin/perl
# columnas_a_filas.pl
# Jonathan Maldonado
# github: jomaldon
# ultima version: Junio 2019

# Transforma un archivo que tiene en una fila un ID y muchos GOs en un archivo que tiene un ID y un GO por fila
# En el resultado el ID se repetirá en distintas filas tantas veces como el número de GOs que tenía

# El archivo de entrada debe estar separado por "tab"
# El archivo de salida estará separado por "tab"
# El archivo de salida estará ordenado por ID

# Uso:
# columnas_a_filas.pl entrada.txt > salida.txt

# entrada.txt tiene múltiples columnas / salida.txt tendrá dos columnas

use strict;

my $in_file = $ARGV[0];

open INFILE, $in_file or die "no pude abrir $in_file";

my @out;

while(<INFILE>){
  chomp;
  s/^ +//;
  s/\t/\|/; # only the firt tab converted to pipe

  my ($key,$GOs) = split(/\|/);
  
  my @GOss = split(/\t/,$GOs);

  my $GO;
  foreach $GO (@GOss) {
#        print "$key,$GO\n";
	push(@out, "$key\t$GO");
  }
}

my @sorted = sort @out;

my %seen = ();
my $item;

foreach $item (@sorted) {
    print "$item\n"  unless $seen{$item}++;
}

close INFILE;
