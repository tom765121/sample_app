class UserMailer < ApplicationMailer
  default from: 'tom765121@gmail.com'
 
  def welcome_email(user)
    @user = user
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def mailgun_welcome_email(user)
  	@user = user
    mg_client = Mailgun::Client.new ENV['mg_api_key']
    message_params = {:from    => ENV['mg_from_email'],
                      :to      => user.email,
                      :subject => 'Sample Mail using Mailgun API',
                      :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    mg_client.send_message ENV['mg_domain'], message_params
	end

end
