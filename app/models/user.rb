class User < ApplicationRecord
  validates :email, presence: true
  validates :flat_id, presence: true

  def flat_key
    FlatService.flat_key
  end
end
