# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts
  attr_accessor :remember_token
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Returns the hash digest o the given string
  def self.digest(string)
    BCrypt::Password.create(string)
  end

  # Return random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remember a user in the database for use in persistent session
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_token, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forget a user
  def forget
    update_attribute(:remember_token, nil)
  end
end
