class User < ApplicationRecord
	attr_accessor :remember_token
	before_save {self.email = self.email.downcase}
	validates :name, presence: true, length: {maximum: 50, minimum: 5}
	VALID_EMAIL_REGEX = /\A[\w+.\-]+@([a-z\d\-]+\.)+[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 250, minimum: 5}, format: { with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
	validates :password, length: {minimum: 5}
	has_secure_password

	def self.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def self.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(self.remember_token))
	end

	def authenticated?(remember_token)
		self.remember_digest && BCrypt::Password.new(self.remember_digest).is_password?(remember_token)
	end

end


