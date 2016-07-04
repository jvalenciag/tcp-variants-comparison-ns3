echo "Generating plots!"

gnuplot plot_comp.gp &

while IFS=$',' read -r -a tcp_conf
do
 prot=${tcp_conf[0]}
 max_y=${tcp_conf[1]}
 echo "$prot"
 
 gnuplot -e "prot_name='$prot'; maxy=$max_y" plot_cwnd_ssthresh.gp &
# gnuplot -e "prot_name='$prot'; maxy=$max_y" plot_2_flows.gp &
done < tcp_comp.conf

gnuplot plot_per_delay_comp.gp &

wait


