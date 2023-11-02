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