require 'rails_helper'

RSpec.describe Request, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:score)}
    it {should validate_presence_of(:username)}
  end
end
