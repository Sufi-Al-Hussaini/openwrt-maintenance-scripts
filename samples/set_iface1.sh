#!/usr/bin/expect -f

set AP_IPADDR 	[lindex $argv 0];
set AP_USRNM	[lindex $argv 1];
set AP_PWD 		[lindex $argv 2];
set SSID 		[lindex $argv 3];
set KEY 		[lindex $argv 4];
set HIDE 		[lindex $argv 5];

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

# Configure iface 1
send "uci set wireless.@wifi-iface\[0\].ssid='$SSID'\r"
send "uci set wireless.@wifi-iface\[0\].encryption=psk2\r"
send "uci set wireless.@wifi-iface\[0\].key='$KEY'\r"
send "uci set wireless.@wifi-iface\[0\].hidden=$HIDE\r"

send "uci commit wireless\r"
send "wifi\r"

# Terminate session
send "exit\r"

expect eof
