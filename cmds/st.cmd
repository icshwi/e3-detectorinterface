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

# Set up asyn for stream device
drvAsynSerialPortConfigure "COM1", "/dev/ttyUSB0"
asynOctetSetInputEos ("COM1",0,"\r\n")
asynOctetSetOutputEos ("COM1",0,"\r\n")
asynSetOption ("COM1", 0, "baud", "230400")
asynSetOption ("COM1", 0, "bits", "8")
asynSetOption ("COM1", 0, "parity", "none")
asynSetOption ("COM1", 0, "stop", "1")
#asynSetTraceMask("COM1",-1,0x3F)

# Load FPGA database
dbLoadRecords("DGRIK.template", "SYS=$(SYS), DEVICE=$(TARGET), EVR=$(EVR0), TSEVT = 2")

iocInit
