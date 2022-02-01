class User < ApplicationRecord
  has_many :party_users
  has_many :viewing_parties, through: :party_users
end
