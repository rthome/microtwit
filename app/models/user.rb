class User < ActiveRecord::Base
  attr_accessor :persistent_session_token

  before_save { self.email = email.downcase }

  validates :name,
            presence: true,
            length: { maximum: 128 }
  validates :email,
            presence: true,
            length: { maximum: 512 },
            format: { with: /.+@.+/i },
            uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def User.new_token
    SecureRandom.urlsafe_base64 32
  end

  def remember
    self.persistent_session_token = User.new_token
    update_attribute :persistent_session_digest, User.digest(self.persistent_session_token)
  end

  def forget
    update_attribute :persistent_session_digest, nil
  end

  def authenticated?(session_token)
    return false if persistent_session_digest.nil?
    BCrypt::Password.new(persistent_session_digest).is_password?(session_token)
  end
end
