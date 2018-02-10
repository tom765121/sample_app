class User < ApplicationRecord
	before_save {self.email = self.email.downcase}
	validates :name, presence: true, length: {maximum: 50, minimum: 5}
	VALID_EMAIL_REGEX = /\A[\w+.\-]+@([a-z\d\-]+\.)+[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 250, minimum: 5}, format: { with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
	validates :password, length: {minimum: 5}
	has_secure_password
end


