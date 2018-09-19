# DNS Checker
This is simple script for checking a DNS entry on a nameserver, and sending an alert if it has

It is designed to be scheduled via a cron job

## GEMS

``` ruby
require 'resolv'
require 'net/smtp'
require 'yaml'
```
## Config file

Below are the variables that can be set to configure DNS Checker

### DNS settings
``` yaml
dnsname: github.com
correctip: 192.30.252.131
nameserver: 8.8.8.8
```
### Alert settings
``` yaml
smtpserver: smtp.domain.com
recipients: youremail@domain.com, someoneelse@domain.com
fromaddress: ruby@yourdomain.com
subject: DNS entry for #{name} has changed
body: |
 Appears that a new IP has been set for the DNS entry for #{name}
 Current IPs: #{current_ips}
 New unknown IPs: #{unknown_ips}
 Expected IPs: #{correct_ips}
signature: |
 Thank You,
 DNS Checker
```
