#------------------------------------------------------------------------------- 
# 
# Program Name:  Security Open Port Scanner  
#                 
# 
# Purpose:       THis program will scan for open ports 
#                
#                   
#                 
# 
# Author:        Ausaf M. 
# 
# Created:       10/25/2022 
# 
#------------------------------------------------------------------------------ 

# Establish a connection between the scanning/target system
use Socket;

# Make sure carriage return (\r} works correctly
$| = 1; 

# Declare the variables 
my ($ip, $protocol, $port, $myhouse, $yourhouse, $log);

# Define the TCP port we will use for scanning 
$protocol = getprotobyname('tcp');

# Define any arguments that may be passed to this script
($ip, $port, $port_stop, $log) = @ARGV;

# Check if the user used the -h f1ag
if ($ip eq "-h") {
    &usage();
}

# Set the defaults for the variab1es
$ip = "localhost" if not $ip;
$port = 1 if not $port;
$port_stop = 65535 if not $port_stop;
$log = "qsopenports.txt" if not $log;


# Open the log file - terminate if it does not open 
unless (open(LOG_FILE, ">>$log")) {
    die "Can't open log file $log for writing: $!\n"
}

# Make file handle hot so the buffer is flushed after every write
# and select the first recor of the log file
select((select(LOG_FILE), $| = 1)[0]);

print LOG_FILE "The following ports are open on $ip between port $port and $port_stop\n\n";

print "Checking $ip for open ports..\n";

# Loop from 1 to the port_stop
for (; $port < $port_stop; $port += 1) {
    socket(SOCKET, PF_INET, SOCK_STREAM, $protocol);

    $yourhouse = inet_aton($ip);

    $myhouse = sockaddr_in($port, $yourhouse);

    # Chect if the port is open
    if (!connect(SOCKET, $myhouse)) {
        printf "%d\r", $port;
    } else {
        printf "%d  <- open\n", $port;
        print LOG_FILE "$port\n";
        close SOCKET || die "close: $!";
    }
}

close LOG_FILE || die "close: $!";
printf "QuickScan complete.\n";
printf "Those are the open ports for: $ip\n";

sub usage() {
    print "Usage: ./quickscan [host] [start port] [stop port] [logfile]\n";
    print "Defaults to localhost and port 1 and port 1024 qsopenports.txt\n";
    exit 0;
}