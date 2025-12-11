class User < ApplicationRecord
    attr_accessor :remember_token
  
    has_secure_password

    def self.digest(string)
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create(string, cost: cost)
    end
  
    def self.new_token
      SecureRandom.urlsafe_base64
    end  

    def remember
      self.remember_token = User.new_token
      update_column(:remember_digest, User.digest(remember_token))
    end
  
    def authenticated?(attribute, token)
      digest = send("#{attribute}_digest")
      return false if digest.nil?   
  
      BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
      update_column(:remember_digest, nil)
    end
    

  require "digest/md5"
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true
  validates :email, presence: true
  validates :name, length: { maximum: 50 }
  validates :email, length: { maximum: 255 }
  validates :email, uniqueness: true
  has_secure_password
end