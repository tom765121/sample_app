class Alarm < ApplicationRecord
	before_save {self.message = self.message.upcase}
	validates :message, presence: true, length: {maximum: 200}
	# this can be done in backgroud
	def send_alarms_to_all_users
		sender = User.find(self.user_id)
		User.all.each do |user|
			puts "#{sender.name} send msg: #{self.message}, to user: #{user.name}"
		end
		return true
	end
end
