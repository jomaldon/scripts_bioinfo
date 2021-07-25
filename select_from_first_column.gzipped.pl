#!/usr/bin/perl
use strict;

sub print_uso{
print "Uso:
        select_est archivo_fuente lista_identificadores
        select_est -r archivo_fuente lista_identificadores (para seleccion inversa)\n";
}

my $rev = 0;            # reverso?

if($ARGV[0] eq "-r"){
        $rev = 1;
}

# si los parametros no son la cantidad correcta, salimos
if($#ARGV != (1+$rev)){
        print_uso();
        exit;
}

# leemos lista de identificadores y lo recordamos en un arreglo asociativo
my %ids;
my %ids_estan;
my @array;
open LISTFILE, $ARGV[1+$rev] or die "No pude abrir lista ($ARGV[1+$rev])!\n";
my $s = "";
my $count =0;
my $count2 =0;
while( $s = <LISTFILE> ){
        chomp($s);
        $ids{$s} = 1;
        $ids_estan{$s} = 1;
        $count++;
}

open(SRCFILE, "gunzip -c $ARGV[$rev] |") or die "gunzip $ARGV[$rev]: $!";
while (<SRCFILE>){
        chop;
        @array = split("\t", $_);
        $s = $array[1];
        if(($ids_estan{$s} == 1)){
                $ids_estan{$s} = 2;
        }
        if(($ids{$s} == 1)){            #la buscamos en arr_aso
                print "$array[1]\t$array[2]\n";
                $count2++;
        }
        if($count2 eq $count){
                last;
        }
}

foreach my $key (keys %ids_estan){
        if($ids_estan{$key} == 1){
                print  STDERR "$key no estaba en archivo fasta.\n";
        }
}
