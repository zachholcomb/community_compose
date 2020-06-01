require 'rails_helper'

RSpec.describe 'User Dashboard', type: :feature do
  describe 'As a logged in user when I visit the dashboard I can' do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user)
                                                  .and_return(@user)
      json_user_resp = File.read('spec/fixtures/flat/user.json')
      stub_request(:get, "https://api.flat.io/v2/me").to_return(status: 200, body: json_user_resp, headers: {})
      json_score_resp = File.read('spec/fixtures/flat/user_scores.json')
      stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200, body: json_score_resp, headers: {})
      visit users_dashboard_index_path
    end

    it 'see my Flat profile information' do
      expected1 = nil
      File.open('spec/fixtures/flat/user.json') do |file|
        file.each_line do |line|
          expected1 = JSON.parse(line, symbolize_names: true)
        end
      end

      expected2 = nil
      File.open('spec/fixtures/flat/user_scores.json') do |file|
        file.each_line do |line|
          expected2 = JSON.parse(line, symbolize_names: true)
        end
      end

      expect(page).to have_content("User Name: #{expected1[:username]}")
      expect(page).to have_content("Number of Scores: #{expected1[:ownedPublicScoreCount]}")
      expect(page).to have_content("Following: #{expected1[:followingCount]}")
      expect(page).to have_content("Followers: #{expected1[:followersCount]}")
      expect(page).to have_content('My Scores:')
      within('.scores') do
        expect(page).to have_content(expected2[0][:title])
      end
    end
  end
end
