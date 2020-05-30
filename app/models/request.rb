class Request < ApplicationRecord
  validates :score, presence: true
  validates :username, presence: true
end
