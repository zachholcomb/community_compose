class User < ApplicationRecord
  validates :email, presence: true

  def flat_key
    # will make dynamic later
    ENV['FLAT_KEY']
  end
end
