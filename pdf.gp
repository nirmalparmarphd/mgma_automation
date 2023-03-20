
#load 'pdfcairo.txt'
set term pdfcairo enhanced dashed font 'FreeSans, 12'
set grid
set xlabel 'Heat Capacity [J/molK]'
set macros

P = "ps 2"
p = "ps 1"
q = "ps 1"
#set size square

set output "pdf-group-a-1s-1r.pdf"
set key bottom right
set ytics nomirror
set y2label "ddf"
set y2tics auto
set xlabel 'Heat Capacity [J/molK]'
set ylabel 'pdf'
set grid
set key font ",12"

pdf = '1:3'
ddf = '1:4'
exp = '6:8'
mg = 'u @pdf with lines lt 1 title "pdf", "" u @exp lt -1 pt 4 @q notitle,"" u @ddf axis x1y2 with lines lt 2 title "ddf"' 

do for [fn in system('ls -1 group-a-1s-1r-*.text')]{
    set title 'Cell-'.fn
    plot fn @mg
}

set out
quit

