require 'net/smtp'
require 'yaml'


def send_message(subject, body)
#Loading YAML variables
config_file_location = File.join(File.dirname(__FILE__), '/dns_checker_config.yml')
config = YAML.load_file(config_file_location)
recipients = config["recipients"].split(",")
smtpserver = config["smtpserver"]
from = config["fromaddress"]
signature = config["signature"]

header = <<HEADER_END
From: DNS Checker <#{from}>
To: #{recipients.join(",")}
Subject: #{subject}
HEADER_END

message = header + "\n" + body + "\n\n" + signature

Net::SMTP.start(smtpserver) do |smtp|
  smtp.send_message message, from, recipients
end
end
