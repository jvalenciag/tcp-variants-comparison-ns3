set terminal pdf
set output 'results/tcp_comp.pdf'
set grid
set autoscale y
set format y '%.0s%cB'
set xrange [0:30]
#set yrange [0:maxy]
set xlabel 'Tempo (segs)'
set ylabel 'segmentos'
plot "data/TcpWestwoodPlus_1-cwnd.data" using 1:2 with lines title 'Westwood+', \
 "data/TcpCubic_1-cwnd.data" using 1:2 with lines title 'Cubic',\
 "data/TcpNewReno_1-cwnd.data" using 1:2 with lines title 'NewReno'
 unset output

