class User < ApplicationRecord
  has_many :party_users
  has_many :viewing_parties, through: :party_users

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  has_secure_password
end
