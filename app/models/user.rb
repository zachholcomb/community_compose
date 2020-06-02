class User < ApplicationRecord
  validates :email, presence: true
  validates :zip, presence: true
  validates :flat_id, presence: true
end
