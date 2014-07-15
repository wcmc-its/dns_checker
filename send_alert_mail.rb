require 'net/smtp'
require 'yaml'


def send_message(subject, body)
#Loading YAML variables
config = YAML.load_file("dns_checker_config.yml")
recipients = config["recipients"].split(",")
smtpserver = config["smtpserver"]
from = config["fromaddress"]


message = <<MESSAGE_END
From: DNS Checker <#{from}>
To: #{recipients.join(",")}
Subject: #{subject}

#{body}

Thank You,
DNS Checker
MESSAGE_END

Net::SMTP.start(smtpserver) do |smtp|
  smtp.send_message message, from, recipients
end
end