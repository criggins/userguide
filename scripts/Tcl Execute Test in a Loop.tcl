#Tcl 

## Run a pre-configured SwiftTest project for N number of times.


###### Variables to CHANGE

set NumberofTimes 3

#### Required Project and Test information to configure
##
## FILL IN the 5 variables below (determined by where the product is installed and which Project is to be run)
##
##   SwiftCMD - full path to SwiftCMD.exe
##   ProjectDir - where Project files are stored
##   TestName - the name of the Project to execute
##   AutomationDir - location where Automation files are Generated  (default = AutomationConfig folder in the Project folder)
##   StartCmd - whether to execute fully (/Start) or just to Validate (/Verify)
##
##   {InstallationFolder} = the name of the folder that was selected at Install time  (default = SwiftTest TDE)
##   {UserLoginName} = user id of the User who installed the TDE
##
## Examples:
##    WindowsXP:  set ProjectDir "C:/Documents and Settings/{UserLoginName}/My Documents/SwiftTest/My Projects"
##    Windows7:   set ProjectDir "C:/Users/{UserLoginName}/Documents/SwiftTest/My Projects"
####

## On a Windows 7 system:

set SwiftCMD    "C:/Program Files/SwiftTest/{InstallationFolder}/swiftcmd.exe"
set ProjectDir  "C:/Users/{UserLoginName}/Documents/SwiftTest/My Projects"
set TestName    "CIFS-SMB Full Duplex Payload"

set AutomationDir  "$ProjectDir/$TestName/AutomationConfig"

## Set StartCmd to:  "/Start" (for normal test runs) -or- " /Verify" (for validation only runs)
   set StartCmd  "/Verify"
#  set StartCmd  "/Start"



###### Fixed Variables

set TestConfigFile        "$ProjectDir/$TestName/$TestName.swift_test" 
set AutomationConfigFile  "$AutomationDir/AutomationConfig.xml" 

## Note:  Running, Validating, or Compiling a test in the SwiftTest TDE (GUI) or via SwiftCMD will NOT rebuild or overwrite the AutomationConfig.xml file.
##        When needed, select the "Generate Automation Files" from the Project menu, or use the "SwiftCMD /Generate" option to rebuild the AutomationConfig.xml file.

set TimeStamp   {clock format [clock seconds] -format "\n\[%Y/%m/%d\ %T %a\]"}



###### Begin

puts "\n\n\n\n===================================================================================================="

## Confirm validity of the original project with conformance (/update) & syntax (/compile) checks 
##
puts "[eval $TimeStamp] -- Performing pre-test /update & /compile operations for conformance & syntax checks on the project:  $TestName \n"
puts "SwiftTest Command: \[exec $SwiftCMD /update /compile  /project:$TestConfigFile ] \n"
puts                    " [exec $SwiftCMD /update /compile  /project:$TestConfigFile ] \n\n"


## Generate fresh Automation files -- (this step is optional - ie. for demonstration purposes) 
##
puts "[eval $TimeStamp] -- Generating fresh Automation files for the project:  $TestName \n\n"
puts "SwiftTest Command: \[exec $SwiftCMD /generate /force  /project:$TestConfigFile /out:$AutomationDir ] \n"
puts                    " [exec $SwiftCMD /generate /force  /project:$TestConfigFile /out:$AutomationDir ] \n\n"


set LoopStartTime [clock seconds]
set LoopStartTimeString [eval $TimeStamp]



###### Main Loop

for {set N 1} {$N <= $NumberofTimes} {incr N} {
	
	puts "\n- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	
	puts "[eval $TimeStamp] -- Preparing Test #$N (of $NumberofTimes):  $TestName \n"
	##
	## Here, you can alter different aspects of the test configuration.
	#  For example, you can increment the load height, or cycle through different scenarios, IP's, User Parameter files, toggle action parameters, etc.
	##
	puts "[eval $TimeStamp] --  . Configuration Changes for Test #$N:  (none) \n"
	##
	
	## EXECUTE the Test now using the "AutomationConfig.xml" file
	##
	set StartTime [clock seconds]
	set StartTimeString [eval $TimeStamp]
	puts "[eval $TimeStamp] -- Executing Test #$N (of $NumberofTimes):  $TestName \n"
	##
	puts "SwiftTest Command: \[exec $SwiftCMD $StartCmd /project:$TestConfigFile  /config:$AutomationConfigFile ] \n \n(please wait)"
	puts                    " [exec $SwiftCMD $StartCmd /project:$TestConfigFile  /config:$AutomationConfigFile ] \n"
	##
	puts "$StartTimeString -- test start time {from above}"
	puts "[eval $TimeStamp] -- Finished  Test #$N (of $NumberofTimes):  $TestName \n"
	puts "  Duration: [clock format [expr [clock seconds] - $StartTime] -gmt 1 -format %H:%M:%S] (h:m:s) \n\n"
	
	## Sleep 3 secs, then run another test.
	after 3000 
}


###### Finished Main Loop
##
puts ""
puts "----------------------------------------------------------------------------------------------------"
puts "$LoopStartTimeString -- Loop start time {from top}"
puts "[eval $TimeStamp] -- Finished $NumberofTimes (of $NumberofTimes) Test runs of project:  $TestName  \n"
puts "  Duration: [clock format [expr [clock seconds] - $LoopStartTime] -gmt 1 -format %H:%M:%S] (h:m:s) \n"
puts "----------------------------------------------------------------------------------------------------\n\n"


exit

