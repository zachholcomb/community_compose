class User < ApplicationRecord
  validates :email, presence: true

  attr_reader :username

  def flat_key
    # will make dynamic later
    ENV['FLAT_KEY']
  end
end
