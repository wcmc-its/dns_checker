# DNS Checker
This is simple script for checking a DNS entry on a nameserver, and sending an alert if it has changed. Supports ipv4 (A) and ipv6 (AAAA) DNS records

It is intended to be scheduled to run via cron job

## GEMS

``` ruby
require 'resolv'
require 'net/smtp'
require 'yaml'
```
## Config file

Below are the variables that can be set to configure DNS Checker in dns_checker_config.yml. See the comments in that file for more details and examples.

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
```
