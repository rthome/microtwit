class User < ActiveRecord::Base
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
end
