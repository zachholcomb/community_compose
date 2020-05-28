class User < ApplicationRecord
  validates_presence_of :email

  def flat_key
    ENV['FLAT_KEY']
  end
end
