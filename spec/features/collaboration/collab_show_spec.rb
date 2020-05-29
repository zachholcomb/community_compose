require 'rails_helper'

RSpec.describe 'Collaborators Features: ', type: :feature do
  describe 'As a user when I view a score ' do
    before(:each) do
      @logged_in_user = create(:user)
      @new_user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user)
                                                  .and_return(@logged_in_user)
      json_user_resp = File.read('spec/fixtures/flat/user.json')
      stub_request(:get, "https://api.flat.io/v2/me").to_return(status: 200, body: json_user_resp, headers: {})
      json_score_resp = File.read('spec/fixtures/flat/user_scores.json')
      stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200, body: json_score_resp, headers: {})

      visit users_dashboard_index_path

      json_score_show_resp = File.read('spec/fixtures/flat/score_show.json')
      expected = nil
      File.open('spec/fixtures/flat/user_scores.json') do |file|
        file.each_line { |line| expected = JSON.parse(line, symbolize_names: true) }
      end
      stub_request(:get, "https://api.flat.io/v2/scores/#{expected[0][:id]}").to_return(status: 200, body: json_score_show_resp, headers: {})

      within('.scores') do
        click_link 'Funk'
      end
    end
    it 'I can see the collaborators on the score' do
      expect(current_path).to eq(scores_path)
      within('.collaborators') do
        expect(page.all("li").count).to eq(1)
        expect(page).to have_content('tylerpporter')
      end
    end
  end
end
