#!/bin/bash

#PROTOCOL=$1
DURATION=$1
PERROR=$2
DELAY=$3
OUPUT_PREFIX=$4
LIMIT=1 #$5
#i=1

#declare -a arr=("TcpTahoe" "TcpNewReno" "TcpWestwood" "TcpCubic" "TcpWestwoodPlus")
declare -a arr=()

while IFS=$',' read -r -a tcp_conf
do
 arr+=(${tcp_conf[0]})
done < tcp_comp.conf

echo "Running simulations!"

for ((i=1; i <= $LIMIT ; i++))
do
	echo $DURATION
       	
	for PROTOCOL in "${arr[@]}"
    do
        FILE_PREFIX=$OUPUT_PREFIX$PROTOCOL
        #echo "$prot" --tracing
        ../Release/tcp-variant-comparsion --transport_prot=$PROTOCOL  --run=$((RANDOM%100+1)) \
        --error_p=$PERROR --duration=120 \
        --bandwidth=10Mbps --access_bandwidth=100Mbps --data=1024 --num_flows=1 --delay=$DELAY \
        --tr_name="$FILE_PREFIX"_$i.tr --cwnd_tr_name="$FILE_PREFIX"_$i-cwnd.data \
        --ssthresh_tr_name="$FILE_PREFIX"_$i-ssthresh.data  --flow_monitor_file="$FILE_PREFIX"_$i-flowmonitor.xml &
    done
	wait
done

#./run_plots.sh
