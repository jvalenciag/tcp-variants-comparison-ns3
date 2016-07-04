import sys
import xml.etree.ElementTree as ET
import shlex, subprocess
import numpy as np

protocols=["TcpTahoe","TcpNewReno", "TcpCubic", "TcpWestwoodPlus"]
pers = [1e-4,1e-3,1e-2,0.05,0.07]
delays = [0.01,50.0,100.0,150.0,200.0,250.0]

default_delay = 45
default_per = 0.005
default_duration = 120

def sizeof_fmt(num, suffix='bps'):
    for unit in ['','K','M','G','T','P','E','Z']:
        if abs(num) < 1000.0:
            return "%3.1f%s%s" % (num, unit, suffix)
        num /= 1000.0
    return "%.1f%s%s" % (num, 'Yi', suffix)

def read_ns_to_sec(num_str):
	return float(num_str[:-2])/1e+9

def parse_flowmonitor(filename):
	tree = ET.parse(filename) 
	root = tree.getroot()
	flowstat = root[0]
	flow = flowstat[0]
	#for flow in flowstat:
	#print( "=========================================")
	#print( "Flow Nr "+str(flow.attrib["flowId"]))
	#print( "=========================================")
	ret = {}

	delay_sum = read_ns_to_sec(flow.attrib["delaySum"])
	rx_packets = float(flow.attrib["rxPackets"])
	ret["mean_delay"] = delay_sum/rx_packets
	
	jitter_sum = read_ns_to_sec(flow.attrib["jitterSum"])
	ret["mean_jitter"] = delay_sum/(rx_packets-1)
	
	tx_bytes = float(flow.attrib["txBytes"])
	tx_packets = float(flow.attrib["txPackets"])
	ret["mean_tx_pckt_size"] = tx_bytes/tx_packets
	
	rx_bytes = float(flow.attrib["rxBytes"])
	rx_packets = float(flow.attrib["rxPackets"])
	ret["mean_rx_pckt_size"] = rx_bytes/rx_packets

	time_last_tx_pckt = read_ns_to_sec(flow.attrib["timeLastTxPacket"])
	time_first_tx_pckt = read_ns_to_sec(flow.attrib["timeFirstTxPacket"])
	ret["mean_tx_bitrate"] = (8*tx_bytes)/(time_last_tx_pckt - time_first_tx_pckt)

	time_last_rx_pckt = read_ns_to_sec(flow.attrib["timeLastRxPacket"])
	time_first_rx_pckt = read_ns_to_sec(flow.attrib["timeFirstRxPacket"])
	ret["mean_rx_bitrate"] = (8*rx_bytes)/(time_last_rx_pckt - time_first_rx_pckt)	

	times_forwarded = float(flow.attrib["timesForwarded"])
	ret["mean_hop_count"] = 1 + times_forwarded/rx_packets

	lost_pckts = float(flow.attrib["lostPackets"])
	ret["pckt_lost_ratio"]= lost_pckts/(rx_packets+lost_pckts)
	return ret

results_prefix = "results/"
data_prefix = "data/"
per_file_name = "per_comp.data"
delay_file_name = "delay_comp.data"

def gen_stats(file_prefix):
	ret = []
	for prot in protocols:
		stats = parse_flowmonitor(file_prefix+prot+"_1-flowmonitor.xml")
		ret.append(stats["mean_tx_bitrate"])
		#print(stats)
	return ret;

def write_stats_to_file(file, first, data=[]):
	file.write("%s " % first)
	for item in data:
		file.write("%s " % item)
	file.write("\n")

print("Runing cwnd tests")
#proc = subprocess.run(["./run_tests.sh", str(default_duration), str(default_per), str(default_delay)+"ms",data_prefix ], stdout=subprocess.PIPE)

print("Runing per tests")
per_file = open(results_prefix+per_file_name, 'w')
for error_p in pers:
	file_prefix = data_prefix+"per_"+'{:.0e}'.format(error_p)+"-"
	#proc = subprocess.run(["./run_tests.sh", str(default_duration), str(error_p), str(default_delay)+"ms",file_prefix ], stdout=subprocess.PIPE)
	#print(proc.stdout)
	data = gen_stats(file_prefix)
	write_stats_to_file(per_file, error_p,data)

per_file.close()

print("Runing delay tests")
delay_file = open(results_prefix+delay_file_name, 'w')
for d in delays:
	file_prefix = data_prefix+"delay_"+str(d)+"-"
	proc = subprocess.run(["./run_tests.sh", str(default_duration), str(default_per), str(d)+"ms", file_prefix ], stdout=subprocess.PIPE)
	#print(proc.stdout)
	data = gen_stats(file_prefix)
	write_stats_to_file(delay_file, d, data)
delay_file.close()