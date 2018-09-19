require 'resolv'
require 'net/smtp'
require 'yaml'
require_relative 'send_alert_mail'


#Loading YAML variables
config = YAML.load_file("dns_checker_config.yml")
name = config["dnsname"]
nameserver = config["nameserver"]
correctip = config["correctip"]

#puts "name #{name}"
#puts "nameserver #{nameserver}"
#puts "correctip #{correctip}"


#Doing the DNS check
Resolv::DNS.open({:nameserver=>[nameserver]}) do |r|
#Resolv::DNS.open(resolvers=[,nameserver]) do |r|
    #$resolvedip = r.getaddresses(name)
    $A_records = r.getresources name, Resolv::DNS::Resource::IN::A
    $AAAA_records = r.getresources name, Resolv::DNS::Resource::IN::AAAA
    $resolvedip = $A_records + $AAAA_records
end

#puts "resolved IPs #{$resolvedip.inspect}"
 
#Begining the comparison
count = $resolvedip.count

resip = Array.new
$resolvedip.each do |ip|
	#resip << ip.to_s
	resip << ip.address.to_s
end

unknown = Array.new
clean = Array.new

resip.each do |ip|
	#puts ip
 if correctip.include?(ip)
  clean << 'Y'
 else 
 	clean << 'N' 
	unknown << ip
 end
end
#Checking that the IP is correct and there is only 1
if clean.include?('N')
	send = 'Y'
	subject =  "DNS entry for #{name} has changed"
	body = "Appears that a new IP has been set for the DNS entry for #{name}\nCurrent IPs #{resip.join(" ")}\nNew unknown IPs #{unknown.join(" ")}" 
else
	send='N'
end

#going to send that email out if we are setting the send value
if send == 'Y'
	send_message(subject, body)#method from send_alert_mail
else
end
