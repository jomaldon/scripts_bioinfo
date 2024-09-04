#!/usr/bin/perl
use strict;
use warnings;

# Verifica si se proporcionaron los nombres de archivo de entrada y salida
if (@ARGV != 2) {
    die "Uso: $0 archivo_entrada archivo_salida\n";
}

my ($input_file, $output_file) = @ARGV;

# Abre el archivo de entrada para lectura
open my $in_fh, '<', $input_file or die "No se puede abrir el archivo '$input_file': $!\n";

# Abre el archivo de salida para escritura
open my $out_fh, '>', $output_file or die "No se puede abrir el archivo '$output_file': $!\n";

# Expresión regular para el patrón del ID en columna 2
my $pattern = qr/(^[A-Z]{2,}[A-Z0-9_]*\d+\.\d)/;

while (my $line = <$in_fh>) {
    chomp $line;
    my @fields = split /\t/, $line;  # Divide la línea en campos usando tabulaciones

    if (length($fields[6]) > 1000) {  # Verifica la longitud del campo en la columna 7 (índice 6)
        $fields[6] = substr($fields[6], 0, 1000);  # Recorta el campo a 1000 caracteres
    }

    #$fields[1] =~ s/[A-Z]{2,}[0-9_]*\d+\.\d+.*/NADA/;
    # Búsqueda del ID en la columna 2 para dejar el espacio entre el ID y el texto
    if ($fields[1] =~ $pattern) {
    	my $code = $1;
    	my $rest = $fields[1];
	$rest =~ s/$code//;  # Elimina el código de la cadena original
	$rest =~ s/^\s+|\s+$//g;  # Elimina espacios en blanco al principio y al final
	$fields[1] = "$rest";
    }

    #if ($fields[6] =~ $pattern) {
    #    my $code = $1;
    #    my $rest = $fields[1];
    #    $rest =~ s/$code//;  # Elimina el código de la cadena original
    #    $rest =~ s/^\s+|\s+$//g;  # Elimina espacios en blanco al principio y al final
    #    $fields[6] = "$code $rest";
    #}

    # Une los campos con tabulaciones y escribe la línea en el archivo de salida
    print $out_fh join("\t", @fields), "\n";
}

# Cierra los archivos
close $in_fh;
close $out_fh;

print "El archivo ha sido modificado y guardado en '$output_file'.\n";
