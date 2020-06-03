class User < ApplicationRecord
  validates :email, presence: true
  validates :zip, presence: true
  validates :flat_id, presence: true


  def distance(distance_list)
    distance_list[self.zip]
  end
end
