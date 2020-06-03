require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:flat_id) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:about) }
    it { should validate_presence_of(:interests) }
    it { should validate_presence_of(:instruments) }
  end
end
