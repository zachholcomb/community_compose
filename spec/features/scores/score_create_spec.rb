require 'rails_helper'

RSpec.describe 'User scores create' do
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

  it 'can create scores from the dashboard' do
    within '.scores' do
      expect(page).to_not have_css('#score-0')
    end
    
    json_new_score_resp = File.read('spec/fixtures/flat/create_score/create_new_score.json')
    stub_request(:post, "https://api.flat.io/v2/scores").to_return(status: 200, body: json_new_score_resp, headers: {})

    click_on('Create Score')
    expect(page).to have_current_path('/scores/new')


    json_score_resp = File.read('spec/fixtures/flat/create_score/users_scores_create_score.json')
    stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200, body: json_score_resp, headers: {})

    fill_in :title, with: 'My New Score'
    click_on 'Submit Score'


    expect(page).to have_current_path('/users/dashboard')
    within '.scores' do
      expect(page).to have_content('My New Score')
    end
  end
end