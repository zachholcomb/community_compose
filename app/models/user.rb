class User < ApplicationRecord
  validates :email, presence: true
  validates :username, presence: true
  validates :flat_id, presence: true

  def flat_key
    # will make dynamic later
    ENV['FLAT_KEY']
  end
end
