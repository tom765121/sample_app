class User < ApplicationRecord
	attr_accessor :authentication_token
	validates :name, presence: true, length: {maximum: 10}
	
	VALID_EMAIL_REGEX = /\A[\w+.\-]+@([a-z\d\-]+.)+[a-z]+\z/i
	validates :email, presence: true, length: {minimum: 10, maximum: 50}, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}
	
	has_secure_password
	validates :password, presence: true, length: {minimum: 8}


	def verify_password?(password)
		return !!self.authenticate(password)
	end

	# def remember_cookies
	# 	cookies.permanent.signed[:user_id] = self.id
	# 	cookies.permanent[:authentication_token] = User.new_random_token
	# 	self.update_attribute(:authentication_digest, User.digest(cookies[:authentication_token]))
	# end


	# def forget_cookies
	# 	cookies.delete(:user_id)
	# 	cookies.delete(:authentication_token)
	# 	self.update_attribute(:authentication_digest, nil)
	# end

	def authenticate?(token)
		BCrypt::Password.new(self.authentication_digest).is_password?(token)
	end

	def generate_authentication_token
		self.authentication_token = User.new_random_token
		self.update_attribute(:authentication_digest, User.digest(self.authentication_token))
	end

	def remove_authentication_token
		self.update_attribute(:authentication_digest, nil)
	end

	private

	def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
	end

	def self.new_random_token
		SecureRandom.urlsafe_base64
	end
end
