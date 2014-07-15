require 'net/smtp'
require 'yaml'

#Loading YAML variables
config = YAML.load_file("dns_checker.config.yml")
recipients = config["recipients"].split(",")
smtpserver = config["smtpserver"]
from = config["fromaddress"]

message = <<MESSAGE_END
From: DNS Checker
To: #{recipients.join(",")}
Subject: #{@subject}

#{@body}

Thank You,
DNS Checker
MESSAGE_END

Net::SMTP.start(smtpserver) do |smtp|
  smtp.send_message message, from, recipients
end
