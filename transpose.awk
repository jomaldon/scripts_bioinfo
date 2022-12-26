# use: awk -v sep=";" -f transpose.awk input_file > output_file
# where "sep" is the column separator of your input_file
#
# modified from
# https://stackoverflow.com/questions/1729824/an-efficient-way-to-transpose-a-file-in-bash

BEGIN { FS=OFS=sep }
{
    for (rowNr=1;rowNr<=NF;rowNr++) {
        cell[rowNr,NR] = $rowNr
    }
    maxRows = (NF > maxRows ? NF : maxRows)
    maxCols = NR
}
END {
    for (rowNr=1;rowNr<=maxRows;rowNr++) {
        for (colNr=1;colNr<=maxCols;colNr++) {
            printf "%s%s", cell[rowNr,colNr], (colNr < maxCols ? OFS : ORS)
        }
    }
}
