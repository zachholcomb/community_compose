class User < ApplicationRecord
  validates :email, presence: true
  validates :zip, presence: true
  validates :flat_id, presence: true
  validates :about, presence: true
  validates :interests, presence: true
  validates :instruments, presence: true

  def distance(distance_list)
    distance_list[zip]
  end
end
