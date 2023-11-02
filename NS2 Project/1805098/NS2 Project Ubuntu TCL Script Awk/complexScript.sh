#Area VAry
#echo "Area Size, Number of Nodes, Number of flows, Packet Per Second, Speed, Sent Packets, Dropped Packets, Received Packets, Network throughput, End-to-end Delay, Packet delivery ratio, Packet drop ratio, Energy Cosumption" > varyArea.csv
# area dimension, nodes, flows, trace file, nam file
#ns project.tcl 250 50 40 200 10 traceArea250.tr animationArea250.nam
#awk -v dim=250 -v nodes=40 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk traceArea250.tr >> varyArea.csv

#ns project.tcl 500 50 40 200 10 traceArea500.tr animationArea500.nam
#awk -v dim=500 -v nodes=40 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk traceArea500.tr >> varyArea.csv

#ns project.tcl 750 50 40 200 10 traceArea500.tr animationArea750.nam
#awk -v dim=750 -v nodes=40 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk traceArea750.tr >> varyArea.csv

#ns project.tcl 1000 50 40 200 10 traceArea500.tr animationArea1000.nam
#awk -v dim=1000 -v nodes=40 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk traceArea1000.tr >> varyArea.csv




#no of nodes vary
echo "Area Size, Number of Nodes, Number of flows, Packet Per Sec, Speed, Sent Packets, Dropped Packets, Received Packets, Network throughput, End-to-end Delay, Packet delivery ratio, Packet drop ratio, Energy Consumption" > varyNodes.csv

ns project.tcl 500 20 20 200 10 traceNodes20.tr animationNodes20.nam
awk -v dim=500 -v nodes=20 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk traceNodes20.tr >> varyNodes.csv

ns project.tcl 500 40 20 200 10 traceNodes40.tr animationNodes40.nam
awk -v dim=500 -v nodes=40 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk traceNodes40.tr >> varyNodes.csv

ns project.tcl 500 60 20 200 10 traceNodes60.tr animationNodes60.nam
awk -v dim=500 -v nodes=60 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk traceNodes60.tr >> varyNodes.csv

ns project.tcl 500 80 20 200 10 traceNodes80.tr animationNodes80.nam
awk -v dim=500 -v nodes=80 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk traceNodes80.tr >> varyNodes.csv

ns project.tcl 500 100 20 200 10 traceNodes100.tr animationNodes100.nam
awk -v dim=500 -v nodes=100 -v flows=20 -v packet_per_sec=200 -v speed=10 -f parse.awk traceNodes100.tr >> varyNodes.csv