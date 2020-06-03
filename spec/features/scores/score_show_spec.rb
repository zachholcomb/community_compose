require 'rails_helper'

RSpec.describe 'As a User', type: :feature do

  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user)
                                                .and_return(@user)
    json_user_resp = File.read('spec/fixtures/flat/user.json')
    stub_request(:get, "https://api.flat.io/v2/me").to_return(status: 200, body: json_user_resp, headers: {})
    json_score_resp = File.read('spec/fixtures/flat/scores_list.json')
    stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200, body: json_score_resp, headers: {})

    visit users_dashboard_index_path

  end
  
  it 'I can see a score show page' do
    json_score_resp = File.read('spec/fixtures/flat/score_show.json')
    
    # expected = nil
    # File.open('spec/fixtures/flat/user_scores.json') do |file|
    #   file.each_line do |line|
    #     expected = JSON.parse(line, symbolize_names: true)
    #   end
    # end
    
    stub_request(:get, "https://api.flat.io/v2/scores/5ed093f4a892cd59c611e0fc").to_return(status: 200, body: json_score_resp, headers: {})
    
    
    within('.scores') do
      click_link 'Funk'
    end
    
    expect(current_path).to eq(scores_path)
    expect(page).to have_content('Funk')
    expect(page).to have_css('#embed-container')
  end

  it 'I can select a score from the dropdown menu' do
    json_score_resp = File.read('spec/fixtures/flat/score_show.json')
    
    # expected = nil
    # File.open('spec/fixtures/flat/user_scores.json') do |file|
    #   file.each_line do |line|
    #     expected = JSON.parse(line, symbolize_names: true)
    #   end
    # end
    
    stub_request(:get, "https://api.flat.io/v2/scores/5ed093f4a892cd59c611e0fc").to_return(status: 200, body: json_score_resp, headers: {})
    
    
    within('.scores') do
      click_link 'Funk'
    end
    
    select 'Country', from: 'scores-menu'
    
    within('#score-title') do
      expect(page).to have_content('Country')
      expect(page).not_to have_content('Funk')
    end
  end
end