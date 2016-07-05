set terminal pdf
set output 'results/delay_comp.pdf'
set grid
set autoscale y
set format y '%.1s%cbps'
#set xrange [0:30]
#set yrange [0:maxy]
set xlabel 'delay (ms)'
set ylabel 'Vazão'
set xtics add (0.01)

plot "results/delay_comp.data" using 1:2 with linespoints title 'Tahoe', \
	"results/delay_comp.data" using 1:3 with linespoints title 'New Reno', \
	"results/delay_comp.data" using 1:4 with linespoints title 'Cubic', \
	"results/delay_comp.data" using 1:5 with linespoints title 'Westwood+'
 unset output

set output 'results/per_comp.pdf'
set xlabel 'Packet error rate'
#set xtics 0,.01,0.07
set logscale x #; #set xtics 0,1e-3,1
set xtics add (0.05)
set xtics add (0.07)
set format y '%.0s%cbps'

 plot "results/per_comp.data" using 1:2 with linespoints title 'Tahoe', \
	"results/per_comp.data" using 1:3 with linespoints title 'New Reno', \
	"results/per_comp.data" using 1:4 with linespoints title 'Cubic', \
	"results/per_comp.data" using 1:5 with linespoints title 'Westwood+'
 unset output