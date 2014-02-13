require 'resolv'
require 'net/smtp'
require 'yaml'

#Loading YAML variables
config = YAML.load_file("dns_checker_config.yml")
name = config["dnsname"]
nameserver = config["nameserver"]
correctip = config["correctip"]
@recipients = config["recipients"].split(",")
@smtpserver = config["smtpserver"]
@from = config["fromaddress"]

#Doing the DNS check
Resolv::DNS.open({:nameserver=>[nameserver]}) do |r|
    $ip = r.getaddresses(name)
end
 
#Begining the comparison
count = $ip.count
resip = $ip.first.to_s
#Checking that the IP is correct and there is only 1
if resip==correctip and count==1
send = 'N'
else
send = 'Y'
@subject =  "Improper #{name} DNS entry set"
@body = "Appears that the DNS entry for #{name} has been altered\n#{$ip.join(' ')}" 
end

#going to send that email out if we are setting the send value
if send == 'Y'
load 'send_alert_mail.rb'
else
end
