require 'rails_helper'

RSpec.describe 'As a User', type: :feature do

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
  
  it 'I can see a score show page' do
    json_score_resp = File.read('spec/fixtures/flat/score_show.json')
    
    expected = nil
    File.open('spec/fixtures/flat/user_scores.json') do |file|
      file.each_line do |line|
        expected = JSON.parse(line, symbolize_names: true)
      end
    end
    
    stub_request(:get, "https://api.flat.io/v2/scores/#{expected[0][:id]}").to_return(status: 200, body: json_score_resp, headers: {})
    
    
    within('.scores') do
      click_link 'Funk'
    end
    
    expect(current_path).to eq(scores_path)
    expect(page).to have_content(expected[0][:title])
    expect(page).to have_css('#embed-container')
  end
end