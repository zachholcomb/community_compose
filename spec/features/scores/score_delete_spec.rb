require 'rails_helper'

RSpec.describe 'Score delete' do
  it 'can delete scores from dashboard' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user)
                                                .and_return(user)
    json_user_resp = File.read('spec/fixtures/flat/user.json')
    stub_request(:get, "https://api.flat.io/v2/me").to_return(status: 200, body: json_user_resp, headers: {})
    json_score_resp = File.read('spec/fixtures/flat/user_scores.json')
    stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200, body: json_score_resp, headers: {})

    visit users_dashboard_index_path

    expected = nil
    File.open('spec/fixtures/flat/user_scores.json') do |file|
      file.each_line do |line|
        expected = JSON.parse(line, symbolize_names: true)
      end
    end

    stub_request(:delete, "https://api.flat.io/v2/scores/#{expected[0][:id]}").to_return(status: 204, body: "", headers: {})

    json_no_score_resp = []
    stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200, body: json_no_score_resp, headers: {})

    within '.scores' do
      expect(page).to have_content('Funk')

      within '#score-0' do
        click_on('Delete')
      end
    end

    expect(page).to have_current_path(users_dashboard_index_path)
    expect(page).to_not have_content('Funk')
  end
end
