#!perl

####### Run a pre-configured SwiftTest project for N number of times.


####### Variables to CHANGE

    my $NumberofTimes = 3 ;

#### Required Project and Test information to configure
##
## FILL IN the 5 variables below (determined by where the product is installed and which Project is to be run)
##
##   $SwiftCMD - full path to SwiftCMD.exe
##   $ProjectDir - where Project files are stored
##   $TestName - the name of the Project to execute
##   $AutomationDir - location where Automation files are Generated  (default = AutomationConfig folder in the Project folder)
##   $StartCmd - whether to execute fully (/Start) or just to Validate (/Verify)
##
##   {InstallationFolder} = the name of the folder that was selected at Install time  (default = SwiftTest TDE)
##   {UserLoginName} = user id of the User who installed the TDE
##
## Examples: 
##    WindowsXP:  my $ProjectDir = '"C:\Documents and Settings\{UserLoginName}\My Documents\SwiftTest\My Projects"' ;
##    Windows7:   my $ProjectDir = '"C:\Users\{UserLoginName}\Documents\SwiftTest\My Projects"' ;
####

## On a Windows 7 system:

    my $SwiftCMD   = '"C:\Program Files\SwiftTest\{InstallationFolder}\swiftcmd.exe"' ;
    my $ProjectDir = '"C:\Users\{UserLoginName}\Documents\SwiftTest\My Projects"' ;
    my $TestName   = '"CIFS-SMB Write"' ;

    my $AutomationDir   = $ProjectDir . "/" . $TestName . "/AutomationConfig" ;


#### Set StartCmd to: "/Start" (for normal test runs) -or- "/Verify" (for validation only runs)

    my $StartCmd  = "/Verify" ;
#   my $StartCmd  = "/Start" ;



####### Fixed Variables

    my $TestConfigFile  = $ProjectDir . "/" . $TestName . "/" . $TestName . ".swift_test" ;
    my $AutomationConfigFile =  $AutomationDir . "/AutomationConfig.xml" ;

## Note:  Running, Validating, or Compiling a test in the SwiftTest TDE (GUI) or via SwiftCMD will NOT rebuild or overwrite the AutomationConfig.xml file.
##        When needed, select the "Generate Automation Files" from the Project menu, or use the "SwiftCMD /Generate" option to rebuild the AutomationConfig.xml file.



####### Begin
    
    print "\n\n\n\n====================================================================================================\n\n\n" ;
    
## Confirm validity of the original project with conformance (/update) & syntax (/compile) checks 
##
    print "Performing pre-test /update & /compile operations for conformance & syntax checks on the project:  $TestName \n\n" ;
    print "SwiftTest Command: $SwiftCMD /update /compile  /project:$TestConfigFile \n" ; 
    print                    `$SwiftCMD /update /compile  /project:$TestConfigFile` ;
    
    
## Generate fresh Automation files -- (this step is optional - ie. for demonstration purposes) 
##
    print "\n\n" ;
    print "Generating fresh Automation files for the project:  $TestName \n\n" ;  
    print "SwiftTest Command: $SwiftCMD /generate /force  /project:$TestConfigFile  /out:$AutomationDir  \n" ; 
    print                    `$SwiftCMD /generate /force  /project:$TestConfigFile  /out:$AutomationDir`  ;
    print "\n\n" ; 
    
    
## Main Loop
    
    for (my $loop=1; $loop<=$NumberofTimes; $loop++ )  {
        
        print "\n- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n\n" ;
        
        print "Preparing Test #$loop (of $NumberofTimes):  $TestName \n\n" ;
        ##
        ## Here, you can alter different aspects of the test configuration.
        #  For example, you can increment the load height, or cycle through different scenarios, IP's, User Parameter files, toggle action parameters, etc.
        ##
        print " . Configuration Changes for Test #$loop:  (none) \n\n" ;
        ##
        
        ## EXECUTE the Test now using the "AutomationConfig.xml" file
        print "Executing Test #$loop (of $NumberofTimes):  $TestName \n\n" ;
        print "SwiftTest Command: $SwiftCMD $StartCmd  /project:$TestConfigFile  /config:$AutomationConfigFile \n \n(please wait)" ;
        print                    `$SwiftCMD $StartCmd  /project:$TestConfigFile  /config:$AutomationConfigFile` ;
        
        print "\nFinished Test #$loop (of $NumberofTimes):  $TestName \n\n" ;
        
        ## Sleep 3 secs, then run another test.
        sleep(3) ;
    } 
    
    
## Finished Main Loop
##
    
    print "\n\n" ;
    print "----------------------------------------------------------------------------------------------------\n" ;
    print "Finished $NumberofTimes (of $NumberofTimes) Test runs of project:  $TestName  \n" ;
    print "----------------------------------------------------------------------------------------------------\n\n\n" ;
    

