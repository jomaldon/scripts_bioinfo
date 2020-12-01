#!/usr/bin/perl
use strict;

### Select_ests
# Nicolas Loira
# 07 Apr 2004

# print_uso muestra uso

sub print_uso{
print "Uso: 
	select_est archivo_fuente lista_identificadores
	select_est -r archivo_fuente lista_identificadores (para seleccion inversa)\n";
}

### MAIN

# Argumentos:
# select_ests fuente lista
# select_ests -r fuente lista (para seleccion reversa)

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
open LISTFILE, $ARGV[1+$rev] or die "No pude abrir lista ($ARGV[1+$rev])!\n";
my $s = "";
while( $s = <LISTFILE> ){
	chomp($s);
	if(index($s,".ab1")>=0) {
		$s = substr($s,0,index($s,".ab1"));
	}
	if(index($s,".scf")>=0) {
		$s = substr($s,0,index($s,".scf"));
	}
#	print "lista: $s\n";
	$ids{$s} = 1;
}

# recorremos cuidadosamente el archivo fuente
# buscamos ">" para anotaciones
# nos preocupamos solo del id! ">id blah blah blah"

my $copiando = 0;	# estado (0: no copiando)

open SRCFILE, $ARGV[$rev] or die "No pude abrir archivo de secuencias ($ARGV[$rev])!\n";
while (<SRCFILE>){
	chop;
	if(/^>([\w.]+)\b/){			#si es anotacion
		$s = $_;
		$s =~ s/^>//;
		$s =~ s/ .*//;
		
		if(index($s,".ab1")>=0) {
			$s = substr($s,0,index($s,".ab1"));
		}
		if(index($s,".scf")>=0) {
			$s = substr($s,0,index($s,".scf"));
		}
		if(($ids{$s} == 1)){		#la buscamos en arr_aso
			$copiando = !$rev;	#cambiamos estado
		}else{
			$copiando = $rev;
		}
#		print "buscando: $s\n";
	}

	# copiamos linea si estamos en estado correcto
	if($copiando){
		print "$_\n";
	}
	else{
		if(/^>([\w.]+)\b/){

	 	#	print "no copiando $_\n";
		}
	}
}

