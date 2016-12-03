#-------Event scheduler object creation--------#

set ns [new Simulator ]

#----------creating nam objects----------------#

set nf [open trace1.nam w]
$ns namtrace-all $nf

set nt [open trace1.tr w]
$ns trace-all $nt

set proto rlm

$ns color 51 royalblue
$ns color 52 coral
$ns color 53 khaki
$ns color 54 limegreen
 
#---------- creating client- router- end server node----------------#

set Client1 [$ns node]
set Client2 [$ns node]
set Client3 [$ns node]
set Client4 [$ns node]
set Router1 [$ns node]
set Router2 [$ns node]
set Router3 [$ns node]
set Router4 [$ns node]
set Endserver1 [$ns node]
set Endserver2 [$ns node]

#---creating duplex link---------#

$ns duplex-link $Client1 $Router1 2Mb 100ms DropTail
$ns duplex-link $Client2 $Router3 4Mb 100ms DropTail
$ns duplex-link $Client3 $Router1 2Mb 100ms DropTail
$ns duplex-link $Client4 $Router2 4Mb 100ms DropTail
$ns duplex-link $Router1 $Router2 100Kb 100ms DropTail
$ns duplex-link $Router2 $Router3 100Kb 100ms DropTail
$ns duplex-link $Router3 $Router4 200Kb 100ms DropTail
$ns duplex-link $Router4 $Endserver1 150Kb 100ms DropTail
$ns duplex-link $Router4 $Endserver2 100Kb 100ms DropTail

#----------------creating orientation--------------------#

$ns duplex-link-op $Client1 $Router1 orient down-right
$ns duplex-link-op $Client2 $Router3 orient up
$ns duplex-link-op $Client3 $Router1 orient up-right
$ns duplex-link-op $Client4 $Router2 orient down-right
$ns duplex-link-op $Router1 $Router2 orient up-right
$ns duplex-link-op $Router2 $Router3 orient down-right
$ns duplex-link-op $Router3 $Router4 orient right
$ns duplex-link-op $Router4 $Endserver1 orient up
$ns duplex-link-op $Router4 $Endserver2 orient down

#------------Labeling----------------#

$ns at 0.0 "$Client1 label Client1"
$ns at 0.0 "$Client2 label Client2"
$ns at 0.0 "$Client3 label Client3"
$ns at 0.0 "$Client4 label Client4"
$ns at 0.0 "$Router1 label Router1"
$ns at 0.0 "$Router2 label Router2"
$ns at 0.0 "$Router3 label Router3"
$ns at 0.0 "$Router4 label Router4"
$ns at 0.0 "$Endserver1 label Endserver1"
$ns at 0.0 "$Endserver2 label Endserver2"

#-----------Configuring nodes------------#

$Client1 color royalblue	
$Client2 color coral
$Client3 color gold
$Client4 color limegreen
$Endserver1 color crimson
$Endserver2 color crimson

$Endserver1 shape hexagon
$Endserver2 shape hexagon
$Router1 shape square
$Router2 shape square
$Router3 shape square
$Router4 shape square

#----------------Establishing queues---------#

$ns duplex-link-op $Client1 $Router1 queuePos 0.1
$ns duplex-link-op $Client2 $Router3 queuePos 0.1
$ns duplex-link-op $Client3 $Router1 queuePos 0.5
$ns duplex-link-op $Client4 $Router2 queuePos 0.1
$ns duplex-link-op $Router1 $Router2 queuePos 0.1
$ns duplex-link-op $Router2 $Router3 queuePos 0.5
$ns duplex-link-op $Router3 $Router4 queuePos 0.1
$ns duplex-link-op $Router4 $Endserver1 queuePos 0.5
$ns duplex-link-op $Router4 $Endserver2 queuePos 0.5


#----------------- Setting up queue/buffer size -------------#

$ns queue-limit $Client1 $Router1 5
$ns queue-limit $Client2 $Router3 5
$ns queue-limit $Client3 $Router1 5
$ns queue-limit $Client4 $Router2 5
$ns queue-limit $Router1 $Router2 5
$ns queue-limit $Router2 $Router3 5
$ns queue-limit $Router3 $Router4 5
$ns queue-limit $Router4 $Endserver1 5
$ns queue-limit $Router4 $Endserver2 5

#---------Establishing communication-------------#

#-------------Client1 to Endserver1---#

set tcp0 [new Agent/TCP]
$tcp0 set maxcwnd_ 16
$tcp0 set fid_ 51
$ns attach-agent $Client1 $tcp0

set sink0 [new Agent/TCPSink]
$ns attach-agent $Endserver1 $sink0

$ns connect $tcp0 $sink0

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

$ns add-agent-trace $tcp0 tcp
$tcp0 tracevar cwnd_

$ns at 0.50 "$ftp0 start"
$ns at 28.5 "$ftp0 stop"

#--------------Client2 to Endserver2---------#

set tcp1 [new Agent/TCP]
$tcp1 set maxcwnd_ 16
$tcp1 set fid_ 52
$ns attach-agent $Client2 $tcp1

set sink1 [new Agent/TCPSink]
$ns attach-agent $Endserver2 $sink1

$ns connect $tcp1 $sink1

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

$ns add-agent-trace $tcp1 tcp
$tcp1 tracevar cwnd_

$ns at 1.60 "$ftp1 start"
$ns at 25.5 "$ftp1 stop"

#------------- Client3 to End server1----------#

set tcp2 [new Agent/TCP]
$tcp2 set maxcwnd_ 16
$tcp2 set fid_ 53
$ns attach-agent $Client3 $tcp2

set sink2 [new Agent/TCPSink]
$ns attach-agent $Endserver1 $sink2

$ns connect $tcp2 $sink2
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

$ns add-agent-trace $tcp2 tcp
$tcp2 tracevar cwnd_

$ns at 0.70 "$ftp2 start"
$ns at 28.5 "$ftp2 stop"


#-------------Client4 to Endserver2---#

set tcp3 [new Agent/TCP]
$tcp3 set maxcwnd_ 16
$tcp3 set fid_ 54
$ns attach-agent $Client4 $tcp3

set sink3 [new Agent/TCPSink]
$ns attach-agent $Endserver2 $sink3

$ns connect $tcp3 $sink3

set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3

$ns add-agent-trace $tcp3 tcp
$tcp3 tracevar cwnd_

$ns at 0.50 "$ftp3 start"
$ns at 28.5 "$ftp3 stop"

#-------------Trace file creation---------#

$ns at 2.4525 "$ns trace-annotate \"Time: 2.4525 Pkt Transfer Path thru node_(1)..\""
$ns at 2.9525 "$ns trace-annotate \"Time: 2.9525 Pkt Transfer Path thru node_(1)..\""
$ns at 3.0025 "$ns trace-annotate \"Time: 3.0025 Pkt Transfer Path thru node_(1)..\""

#---------finish procedure--------#

proc finish {} {
	global ns nf nt
	$ns flush-trace
	close $nf
	close $nt
	puts "Running Nam"
	exec nam trace1.nam
	exit 0
}

 #Calling finish procedure

$ns at 35.0 "finish"
$ns run