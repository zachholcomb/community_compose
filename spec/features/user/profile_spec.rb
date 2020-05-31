require 'rails_helper'

describe 'As a registered user' do
  describe 'when I visit users/:id' do
    scenario 'I should see that users profile' do
      user = create(:user)
      visit user_path(user.id)

      expect(page).to have_content(user.username)
    end
  end
  describe 'when I visit my dashboard' do
    xscenario 'I can click a link to view my profile' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user)
                                                  .and_return(user)
      visit users_dashboard_index_path
      click_link 'My Profile'

      expect(current_path).to eq(user_path(user.id))
    end
  end
end
