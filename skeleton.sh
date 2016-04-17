#!/usr/bin/expect -f

set AP_IPADDR 	[lindex $argv 0];
set AP_USRNM	[lindex $argv 1];
set AP_PWD 		[lindex $argv 2];

# puts "Total: $ARGC argument(s)"

# SSH
spawn ssh -o StrictHostKeyChecking=no $AP_USRNM@$AP_IPADDR
set timeout 10
expect {*?assword:*}
send "$AP_PWD"
send "\r"

# Telnet 
# spawn telnet $AP_IPADDR
# set timeout 10
# expect {*?:/#*}

# Wait for login
sleep 1

# Maintenace work... 
# Send commands to device here


# Terminate session
send "exit\r"

expect eof
