#!/usr/bin/perl
use strict;

sub print_uso{
print "Uso: 
        reads_add_number.pl archivo_fasta_con_reads lista_de_IDs_unicos\n";
}

### MAIN

# Argumentos:
# select_ests fuente lista
# select_ests -r fuente lista (para seleccion reversa)

# si los parametros no son la cantidad correcta, salimos
if($#ARGV != (1)){
        print_uso();
        exit;
}

my %ids;
open LISTFILE, $ARGV[1] or die "No pude abrir lista ($ARGV[1])!\n";

my $s = "";
my $count =0;
while( $s = <LISTFILE> ){
        chomp($s);
        $ids{$s} = 1;
        $count++;
}

#my $copiando = 0;       # estado (0: no copiando)
#my $quien="";

open SRCFILE, $ARGV[0] or die "No pude abrir archivo de secuencias ($ARGV[0])!\n";
while (<SRCFILE>){

        chop;
        if(/^>([\w.]+)\b/){                     #si es anotacion
		$s = $_;
		$s =~ s/^>//;
#		print "$s\t$ids{$s}\n";

		print ">".$s."_".$ids{$s}."\n";
		++$ids{$s};
	}
	else{
		print "$_\n";
	}
}
