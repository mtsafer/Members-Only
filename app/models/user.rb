class User < ApplicationRecord

	attr_accessor :remember_token

	validates :name, :email, presence: true
	validates :password, length: {minimum: 6}

	has_many :articles

	has_secure_password

	# Returns a digested hashing of the given string
	def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

	# Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Saves a remember_digest to the DB
  def remember
  	self.remember_token = User.new_token
  	update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest
  def authenticated?(remember_token)
  	return false if remember_digest.nil?
  	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end


end
