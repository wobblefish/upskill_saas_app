class ContactMailer < ActionMailer::Base
   default to: 'matt.mcneill1984@outlook.com'
   
   def contact_email(name, email, body)
     @name = name
     @email = email
     @body = body
     
     mail(from: email, subject: 'Contact Form Message')
   end
end