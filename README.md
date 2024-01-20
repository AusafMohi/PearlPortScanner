# PearlPortScanner
In this Project, we will be using Perl to create a port scanner program which scans the system for open ports. This is for security/ethical purposes only. 



This Perl program port scanner script is named "quickscan." Here's a summary of its functionality:

-Connection Establishment:

The program uses the Socket module to establish a connection between the scanning/target system.
Carriage Return Setting:

$| = 1; ensures that the carriage return works correctly by disabling buffering.
Variable Declaration:

Variables such as $ip, $protocol, $port, $myhouse, $yourhouse, and $log are declared.
TCP Port Definition:

The TCP protocol is defined using getprotobyname('tcp').
Command-Line Arguments:

The script takes command-line arguments for the target IP ($ip), starting port ($port), stopping port ($port_stop), and a log file ($log).
Default Values:

Default values are set for the variables if not provided by the user.
Log File Handling:

It opens a log file (qsopenports.txt by default) and writes information about open ports to this file.
Port Scanning Loop:

The program then loops through ports from $port to $port_stop and checks if each port is open.
It uses the socket, connect, and close functions to check and log open ports.
Printing Results:

The script prints the open ports to the console and logs them in the specified log file.
Usage Function:

A usage subroutine is defined to provide information on how to use the script.
Summary Output:

The script concludes by printing a message indicating the completion of the quick scan and displaying the open ports for the specified IP.
