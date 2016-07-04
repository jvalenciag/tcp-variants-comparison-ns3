
if (!exists("prot_name")) prot_name='prot'

set terminal pdf
set output 'results/tcp_2_flows-'.prot_name.'.pdf'
#set terminal postscript
#set output '| ps2pdf - output.pdf'
set autoscale y
set xrange [0:30]
set yrange [0:maxy]
set grid
set xlabel 'Tempo (segs)'
set ylabel 'segmentos'
#set key outside

#every ::20
plot "1".prot_name."_1-cwnd.data" using 1:2 with lines title 'thresh', \
 "2".prot_name."_1-cwnd.data" using 1:2 with lines title 'wnd'

