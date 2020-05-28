class User < ApplicationRecord
  validates_presence_of :email

  def flat_key
    # will make dynamic later 
    ENV['FLAT_KEY']
  end
end
