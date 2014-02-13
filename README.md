# DNS Checker
This is simple script for checkin if a DNS entry has chaned against a particular name server and sending an alert 

It is designed to be schedualed via a cron job

## GEMS

``` ruby
require 'resolv'
require 'net/smtp'
require 'yaml'
```
## Config file

Below you will see the vairable we are setting for DNS Checker

### DNS settings
``` ruby
dnsname: github.com 
correctip: 192.30.252.131
nameserver: 8.8.8.8
```
### Alert settings
``` ruby
smtpserver: smtp.domain.com
recipients: youremail@domain.com, someoneelse@domain.com
fromaddress: ruby@yourdomain.com
```
