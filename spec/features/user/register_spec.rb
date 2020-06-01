require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit /' do
    scenario 'I see a link to register' do
      visit '/'
      # fill_in :email, with: 'user@example.com'
      # fill_in :zip, with: '80005'
      #
      # click_button 'Register'
      click_link 'Login'

      expect(current_path).to eq(users_dashboard_index_path)
    end
  end
end
