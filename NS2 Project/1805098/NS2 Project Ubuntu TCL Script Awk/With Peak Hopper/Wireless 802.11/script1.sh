#!/bin/bash
#no of nodes vary
echo "Area Size, Number of Nodes, Number of flows, Packet Per Sec, Speed, Sent Packets, Dropped Packets, Received Packets, Network throughput, End-to-end Delay, Packet delivery ratio, Packet drop ratio, Energy Consumption" > varyNodes.csv

ns project.tcl 500 20 20 200 10 trace.tr animation.nam
awk -v dim=500 -v nodes=20 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk trace.tr >> varyNodes.csv

ns project.tcl 500 40 20 200 10 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk trace.tr >> varyNodes.csv

ns project.tcl 500 60 20 200 10 trace.tr animation.nam
awk -v dim=500 -v nodes=60 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk trace.tr >> varyNodes.csv

ns project.tcl 500 80 20 200 10 trace.tr animation.nam
awk -v dim=500 -v nodes=80 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk trace.tr >> varyNodes.csv

ns project.tcl 500 100 20 200 10 trace.tr animation.nam
awk -v dim=500 -v nodes=100 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk trace.tr >> varyNodes.csv

#no of flow vary
echo "Area Size, Number of Nodes, Number of flows, Packet Per Sec, Speed, Sent Packets, Dropped Packets, Received Packets, Network throughput, End-to-end Delay, Packet delivery ratio, Packet drop ratio, Energy Consumption" > varyFlows.csv

ns project.tcl 500 40 10 200 10 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=10 -v packet_per_sec=200 -v speed=10 -f parse.awk trace.tr >> varyFlows.csv

ns project.tcl 500 40 20 200 10 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk trace.tr >> varyFlows.csv

ns project.tcl 500 40 30 200 10 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=30 -v packet_per_sec=200 -v speed=10 -f parse.awk trace.tr >> varyFlows.csv

ns project.tcl 500 40 40 200 10 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=40 -v packet_per_sec=200 -v speed=10 -f parse.awk trace.tr >> varyFlows.csv

ns project.tcl 500 40 50 200 10 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=50 -v packet_per_sec=200 -v speed=10 -f parse.awk trace.tr >> varyFlows.csv

#Packet Rate vary
echo "Area Size, Number of Nodes, Number of flows, Packet Per Sec, Speed, Sent Packets, Dropped Packets, Received Packets, Network throughput, End-to-end Delay, Packet delivery ratio, Packet drop ratio, Energy Consumption" > varyPacketRate.csv
ns project.tcl 500 40 20 100 10 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=20 -v packet_per_sec=100 -v speed=10 -f parse.awk trace.tr >> varyPacketRate.csv

ns project.tcl 500 40 20 200 10 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk trace.tr >> varyPacketRate.csv

ns project.tcl 500 40 20 300 10 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=20 -v packet_per_sec=300 -v speed=10 -f parse.awk trace.tr >> varyPacketRate.csv

ns project.tcl 500 40 20 400 10 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=20 -v packet_per_sec=400 -v speed=10 -f parse.awk trace.tr >> varyPacketRate.csv

ns project.tcl 500 40 20 500 10 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=20 -v packet_per_sec=500 -v speed=10 -f parse.awk trace.tr >> varyPacketRate.csv

#speed vary
echo "Area Size, Number of Nodes, Number of flows, Packet Per Sec, Speed, Sent Packets, Dropped Packets, Received Packets, Network throughput, End-to-end Delay, Packet delivery ratio, Packet drop ratio, Energy Consumption" > varySpeed.csv
ns project.tcl 500 40 20 200 5 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=20 -v packet_per_sec=200 -v speed=5 -f parse.awk trace.tr >> varySpeed.csv

ns project.tcl 500 40 20 200 10 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk trace.tr >> varySpeed.csv

ns project.tcl 500 40 20 200 15 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=20 -v packet_per_sec=200 -v speed=15 -f parse.awk trace.tr >> varySpeed.csv

ns project.tcl 500 40 20 200 20 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=20 -v packet_per_sec=200 -v speed=20 -f parse.awk trace.tr >> varySpeed.csv

ns project.tcl 500 40 20 200 25 trace.tr animation.nam
awk -v dim=500 -v nodes=40 -v flows=20 -v packet_per_sec=200 -v speed=25 -f parse.awk trace.tr >> varySpeed.csv