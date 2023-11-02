# simulator
set ns [new Simulator]


# ======================================================================
# Define options

set val(chan)         Channel/WirelessChannel  ;# channel type
set val(prop)         Propagation/TwoRayGround ;# radio-propagation model
set val(ant)          Antenna/OmniAntenna      ;# Antenna type
set val(ll)           LL                       ;# Link layer type
set val(ifq)          Queue/DropTail/PriQueue  ;# Interface queue type
set val(ifqlen)       50                       ;# max packet in ifq
set val(netif)        Phy/WirelessPhy          ;# network interface type
set val(mac)          Mac/802_11               ;# MAC type
set val(rp)           AODV                     ;# ad-hoc routing protocol 
set val(nn)           40                       ;# number of mobilenodes
set val(nf)           20                       ;# number of flows 
# =======================================================================

#set area dimension mane 500 by 500 size er area
#Eikhane set kore dilam jate change korar somoy just ek jayga te change kora lage  
set dimension 500

# trace file
set trace_file [open trace.tr w]
$ns trace-all $trace_file

# nam file
#nam file er size tao 500 by 500 korte chai
set nam_file [open animation.nam w]
$ns namtrace-all-wireless $nam_file $dimension $dimension

# topology: to keep track of node movements
# eita kintu nam file er grid na, main topology er grid 
set topo [new Topography]
$topo load_flatgrid $dimension $dimension ;# 500m x 500m area


# general operation director for mobilenodes
create-god $val(nn)



# node configs
# ======================================================================

# $ns node-config -addressingType flat or hierarchical or expanded
#                  -adhocRouting   DSDV or DSR or TORA
#                  -llType	   LL
#                  -macType	   Mac/802_11
#                  -propType	   "Propagation/TwoRayGround"
#                  -ifqType	   "Queue/DropTail/PriQueue"
#                  -ifqLen	   50
#                  -phyType	   "Phy/WirelessPhy"
#                  -antType	   "Antenna/OmniAntenna"
#                  -channelType    "Channel/WirelessChannel"
#                  -topoInstance   $topo
#                  -energyModel    "EnergyModel"
#                  -initialEnergy  (in Joules)
#                  -rxPower        (in W)
#                  -txPower        (in W)
#                  -agentTrace     ON or OFF
#                  -routerTrace    ON or OFF
#                  -macTrace       ON or OFF
#                  -movementTrace  ON or OFF

# ======================================================================

$ns node-config -adhocRouting $val(rp) \
                -llType $val(ll) \
                -macType $val(mac) \
                -ifqType $val(ifq) \
                -ifqLen $val(ifqlen) \
                -antType $val(ant) \
                -propType $val(prop) \
                -phyType $val(netif) \
                -topoInstance $topo \
                -channelType $val(chan) \
                -agentTrace ON \
                -routerTrace ON \
                -macTrace OFF \
                -movementTrace OFF

# create nodes
for {set i 0} {$i < $val(nn) } {incr i} {
    set node($i) [$ns node]
    $node($i) random-motion 0       ;# disable random motion, amra chacchi ekta valo motion dite

    #All time 10 Col
    #distance from one node to another 
    #set temp1 [expr {($dimension / 10)}]

    #setting y distance 
    #set temp2 25
    set Dist [expr {($dimension / 10)}]
    #for max 100 nodes 10 by 10
    #initial position set kora holo  
    $node($i) set X_ [expr {(($i % 10 )*$Dist)+1}]
    $node($i) set Y_ [expr {(($i / 10 )*$Dist)+1}]
    $node($i) set Z_ 0

    #eije value 20 dicchi eita size...node object and size 
    $ns initial_node_pos $node($i) 20


    #puts "Before Setting destination"
    #node ke jodi kono destination e pathate chai tahole 
    #dest set korar somoy rand() to same output dibe na 
    #tai initial pos ar dest pos sem hobe na

    #0 and dimention hote parbe na ; tai while loop 
    set temp [expr {int(rand()*$dimension)+1}]
    while {$temp==$dimension} {
        set temp [expr {int(rand()*$dimension)+1}]
    }
    set Xdest [expr {$temp}]
    #puts $temp

    set temp [expr {int(rand()*$dimension)+1}]
    while {$temp==$dimension} {
        set temp [expr {int(rand()*$dimension)+1}]
    }
    set Ydest [expr {$temp}]
    #puts $temp
    #question e bole diche je 1 to 5
    set speed [expr {int(rand()*5)+1}]

    #ei speed e destination er dike ogroshor hobe 
    $ns at 1.0 "$node($i) setdest $Xdest $Ydest $speed" 

}

puts "After setting alll nodes"





#Traffic

#setting the sink as oke sink fixed rakhte bolche, dest hocche variable tar nam
set src [expr {int(rand()*$val(nn))}]
#Source will be chosen randomly for each flow and sink will be this dest for all flows

puts "Before setting all flows"
for {set i 0} {$i < $val(nf)} {incr i} {
    set dest [expr {int(rand()*$val(nn))}]

    #jotokkhon source ar destination soman totokkhon rand() call kore kaj korbo
    while {$src == $dest} {
        set dest [expr {int(rand()*$val(nn))}]
    }

  
    #Create Agent
    #udp hocche just variable tar nam
    set udp [new Agent/UDP]
    #The behavior of the traffic in class 2, such as the packet size, rate, and other properties, is defined by the configuration of the simulator.
    
    set udp_sink [new Agent/Null]
    $udp set class_ 2

    #Attach to nodes
    $ns attach-agent $node($src) $udp
    $ns attach-agent $node($dest) $udp_sink

    #connect agents
    $ns connect $udp $udp_sink
    $udp set fid_ $i

    
    #Traffic generator
    #Setup a CBR over UDP connection
    set cbr [new Application/Traffic/CBR]

    #attach to agent, source er agent er sathe attach kore dilam
    $cbr attach-agent $udp

    #CBR er case e ei jinis gula kora lagbe
	$cbr set type_ CBR
	$cbr set packet_size_ 1000
	$cbr set rate_ 1mb
	$cbr set random_ false

   

    #start traffic generation
    $ns at 1.0 "$cbr start"
}

puts "After setting all flows"


#Eigula just sir er code gula
# End Simulation
#Ager position e chole jao and movement o stop kore dao
# Stop nodes
for {set i 0} {$i < $val(nn)} {incr i} {
    $ns at 50.0 "$node($i) reset"
}

# call final function
proc finish {} {
    global ns trace_file nam_file
    $ns flush-trace
    close $trace_file
    close $nam_file
}

proc halt_simulation {} {
    global ns
    puts "Simulation ending"
    $ns halt
}

$ns at 50.0001 "finish"
$ns at 50.0002 "halt_simulation"



# Run simulation
puts "Simulation starting"
$ns run
