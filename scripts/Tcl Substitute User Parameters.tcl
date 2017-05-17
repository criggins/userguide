#TCL

##This script is used to demonstrate how to change multiple values and run the test again####
##Strings that must be replaced
## {UserLoginName} = User id of the User who installed the TDE
## {InstallationFolder} = the folder that the TDE was installed into
## {Auto} = the folder where the Automation files are generated into ("AutomationConfig" by default)

## Save the original User Parameter file ########

file copy -force "C:/Users/{UserLoginName}/Documents/SwiftTest/My Projects/CIFS-SMB Write Demo/UP1.user"
"C:/Users/{UserLoginName}/Documents/Sw

set Dest_IP "192.168.220.10"
set File "YY.TEST"
set Bytes "65000"
set Total_Bytes "650000"
set slash \\
set dir "DUMP"


for { set i 1 } { $i <= 2 } { incr i } {

puts "Executing CIFS-SMB Write Demo #$i \n \n 'n"
#puts [exec "C:/Program Files/SwiftTest/{InstallationFolder}/SwiftCmd.exe" /Start
"/Project:C:/Users/{UserLoginName}/Documents/SwiftTest/My Projects/CIFS-SMB Write Demo/CIFS-SMB Write Demo.swift_test" "/Config:C:/Users/{UserLoginName}/Documents/SwiftTest/My Projects/CIFS-SMB Write Demo/{Auto}/AutomationConfig.xml"]

##Using the follwing to just run once######

puts [exec "C:/Program Files/SwiftTest/{InstallationFolder}/SwiftCmd.exe" /Verify
"/Project:C:/Users/{UserLoginName}/Documents/SwiftTest/My Projects/CIFS-SMB Write Demo/CIFS-SMB Write Demo.swift_test" "/Config:C:/Users/{UserLoginName}/Documents/SwiftTest/My Projects/CIFS-SMB Write Demo/{Auto}/AutomationConfig.xml"]

## Open the User Parameters file inside the Project folder ######

set input [open "C:/Users/{UserLoginName}/Documents/SwiftTest/My Projects/CIFS-SMB Write Demo/UP1.user r]
set output [open "C:/Users/{UserLoginName}/Documents/SwiftTest/My Projects/CIFS-SMB Write Demo/UP1.user.tmp" w]

puts "\n \n \n \n \n"
puts "Changing the Following Values

## Destination IP address ##
set Old_IP { <A>}
set New_IP " <A>$Dest_IP</A>"
puts "IP Address \n"

##File to Write##
set OLD_File { <C>}
set New_File " <C>$File</C>"
puts "File Name \n"

##Bytes Per Request##
set OLD_Bytes_Per_Req { <D>}
set New_Bytes_Per_Req " <D>$Bytes</D>"
puts "Bytes Per Request \n"

##Totat bytes to use ##
set OLD_Total_Bytes { <E>}
set New_Total_Bytes " <E>$Total_Bytes</E>"
puts "Total Bytes \n"

######This loop replaces the values in the user parameter file to the new ones ################
##### Comment out the values that you dont want to change #######

while {[gets $input line] > 0} {

if {[string first $Old_IP $line] >= 0 } {
puts $output $New_IP

} elseif {[string first $OLD_Share $line] >= 0 } {
puts $output $New_Share

} elseif {[string first $OLD_File $line] >= 0 } {
puts $output $New_File

} elseif {[string first $OLD_Bytes_Per_Req $line] >= 0 } {
puts $output $New_Bytes_Per_Req

} elseif {[string first $OLD_Total_Bytes $line] >= 0 } {
puts $output $New_Total_Bytes

} else {
puts $output $line }
}
close $input
close $output

file rename -force "C:/Users/{UserLoginName}/Documents/SwiftTest/My Projects/CIFS-SMB Write Demo/UP1.user.tmp" "C:/Users/{UserLoginName}/Documents/SwiftTest/My Projects/CIFS-SMB Write Demo/UP1.user"

#########Ending the For Loop##################
}
#############Restore the original configuration#######################

file copy -force "C:/Users/{UserLoginName}/Documents/SwiftTest/My Projects/CIFS-SMB Write Demo/UP1.user.org"
"C:/Users/{UserLoginName}/Documents/SwiftTest/My Projects/CIFS-SMB Write Demo/UP1.user"
puts "All Tests Ran Successfully"