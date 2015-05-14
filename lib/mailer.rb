require 'pony'

module Mailer
  def self.send_email(subject, body)
    Pony.mail to: 'itorres@peertransfer.com',
	      from: 'no_response_please@peertransfer.com',
	      subject: subject,
	      body: body
  end
end
