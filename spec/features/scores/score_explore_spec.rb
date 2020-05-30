require 'rails_helper'

RSpec.describe 'User Scores Explore Page: ' do
  describe 'As a user when I visit the scores explore page I ' do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user)
                                                  .and_return(@user)

      json_user_resp = File.read('spec/fixtures/flat/user.json')
      stub_request(:get, "https://api.flat.io/v2/me").to_return(status: 200, body: json_user_resp, headers: {})

      json_score_resp = []
      stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200, body: json_score_resp, headers: {})

      visit users_dashboard_index_path
    end

    it 'can navigate to the scores explore page from my dashboard' do
      click_on 'Explore'

      expect(page).to have_current_path('/users/explore')
    end

    it 'can see scores from my area' do
      click_on 'Explore'

      within '.scores' do
        expect(page.all("li").count).to eq(3)
      end
    end
  end
end
