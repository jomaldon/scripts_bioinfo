#!/usr/bin/perl
use strict;

### Select_ests
# Nicolas Loira
# github: nloira
# 07 Apr 2004
# Modified by Jonathan Maldonado
# github: jomaldon
# 07 Oct 2019

# print_uso muestra uso

sub print_uso{
print "Uso: 
	select_list archivo_fuente lista_identificadores
	select_list -r archivo_fuente lista_identificadores (para seleccion inversa)\n";
}

### MAIN

# Argumentos:
# select_list fuente lista
# select_list -r fuente lista (para seleccion reversa)

my $rev = 0;		# reverso?

if($ARGV[0] eq "-r"){
	$rev = 1;
}

# si los parametros no son la cantidad correcta, salimos
if($#ARGV != (1+$rev)){
	print_uso();
	exit;
}

# leemos lista de identificadores
# y lo recordamos en un arreglo asociativo
my %ids;
my %ids_estan;
open LISTFILE, $ARGV[1+$rev] or die "No pude abrir lista ($ARGV[1+$rev])!\n";
my $s = "";
my $count =0;
while( $s = <LISTFILE> ){
	chomp($s);
	$ids{$s} = 1;
	$ids_estan{$s} = 1;
	$count++;
}

foreach my $key (keys %ids_estan){
#        print "$key es igual a ".$ids_estan{$key}."\n";
        if($ids_estan{$key} == 1){
 #               print  STDERR "$key no estaba en archivo fasta.\n";
        }
}

#print STDERR "total secuencias a seleccionar $count\n";

# recorremos cuidadosamente el archivo fuente
# buscamos ">" para anotaciones
# nos preocupamos solo del id! ">id blah blah blah"

my $copiando = 0;	# estado (0: no copiando)
my $quien="";

open SRCFILE, $ARGV[$rev] or die "No pude abrir archivo de secuencias ($ARGV[$rev])!\n";
while (<SRCFILE>){
	chop;
#	if(/^>([\w.]+)\b/){			#si es anotacion
		$s = $_;
		$s =~ s/^>//;
		$s= substr($s,0,index($s,"\t"));
		#print STDERR $s.".\n";

		if(($ids_estan{$s} == 1)){
#		  print "encontrado $s\n";
		  $ids_estan{$s} = 2;
		}

		if(($ids{$s} == 1)){		#la buscamos en arr_aso
			
			$copiando = !$rev;	#cambiamos estado
		}else{
			$copiando = $rev;
		}
#	}

	# copiamos linea si estamos en estado correcto
	if($copiando){
		print "$_\n";
	}
}

foreach my $key (keys %ids_estan){
	#print STDERR "$key revisando ".$ids_estan{$key}."\n";
	if($ids_estan{$key} == 1){
		print  STDERR "$key no estaba en archivo fasta.\n";
	}
}
