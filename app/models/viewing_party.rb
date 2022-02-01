class ViewingParty < ApplicationRecord
  belongs_to :host
  has_many :party_users
  has_many :users, through: :party_users
end
