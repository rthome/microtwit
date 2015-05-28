class User < ActiveRecord::Base
  has_many :chirps, dependent: :destroy
  has_many :follow_relationships,
           class_name: 'Follow',
           foreign_key: 'follower_id',
           dependent: :destroy
  has_many :follower_relationships,
           class_name: 'Follow',
           foreign_key: 'followed_id',
           dependent: :destroy
  has_many :follows, through: :follow_relationships, source: :followed # People this user follows
  has_many :followers, through: :follower_relationships, source: :follower # People this user is followed by

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
  validates :password, length: { minimum: 6 }, allow_blank: true

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

  def feed
    chirps
  end

  def follow(other)
    follow_relationships.create(followed_id: other.id)
  end

  def unfollow(other)
    follow_relationships.find_by(followed_id: other.id).destroy
  end

  def following?(other)
    follows.include?(other)
  end
end
