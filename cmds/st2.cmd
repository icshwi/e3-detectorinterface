require iocStats,ae5d083
require recsync,1.3.0
#
require detectorinterface,0.3.0
require stream,2.7.14p

epicsEnvSet(       "IOC"   "DG-TS-IOC")
epicsEnvSet(       "SYS"          "DG")
epicsEnvSet(	   "PREVT"         "1") #Reset Prescalers 
epicsEnvSet(	   "TSEVT"	   "2") #Start timestamp sequence (reset->enable->determineTS-> sendTS)
epicsEnvSet(       "TSE"	   "3") #EVG sends TS Enable pulse
epicsEnvSet(	   "TST"           "4")	#EVG sends TS Test pulse to ADC
epicsEnvSet(       "TARGET"     "FPGA")
epicsEnvSet( 	   "EVR0" 	"EVR")

epicsEnvSet("STREAM_PROTOCOL_PATH", $(detectorinterface_DB))
epicsEnvSet("PORTNAME", "COM1")

loadIocsh("iocStats.iocsh", "IOCNAME=$(IOC)")
loadIocsh("recsync.iocsh", "IOCNAME=$(IOC)")

loadIocsh("SetSerialPort.iocsh", "PORT_NAME=$(PORTNAME),TTY_NAME=/dev/ttyUSB0,BAUD=230400")
asynOctetSetInputEos ($(PORTNAME),0,"\r\n")
asynOctetSetOutputEos ($(PORTNAME),0,"\r\n")

#asynSetTraceMask("COM1",-1,0x3F)

# Load FPGA database
dbLoadRecords("DGRIK.template", "SYS=$(SYS), DEVICE=$(TARGET), EVR=$(EVR0), TSEVT = 2")

iocInit
