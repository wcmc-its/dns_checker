require 'net/smtp'

message = <<MESSAGE_END
From: DNS Checker
To: #{@recipients.join(",")}
Subject: #{@subject}

#{@body}

Thank You,
DNS Checker
MESSAGE_END

Net::SMTP.start(@smtpserver) do |smtp|
  smtp.send_message message, @from, @recipients
end
