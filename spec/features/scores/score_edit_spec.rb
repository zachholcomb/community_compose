require 'rails_helper'

RSpec.describe 'As a registered user' do
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user)
                                                .and_return(@user)

    json_user_resp = File.read('spec/fixtures/flat/user.json')
    stub_request(:get, "https://api.flat.io/v2/me").to_return(status: 200, body: json_user_resp, headers: {})

    json_score_resp = File.read('spec/fixtures/flat/create_score/users_scores_create_score.json')
    stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200, body: json_score_resp, headers: {})

    visit users_dashboard_index_path
  end

  it 'I can edit scores' do
    score_id = '5ed093f4a892cd59c611e0fc'

    json_score_resp = File.read('spec/fixtures/flat/create_score/create_new_score.json')
    stub_request(:get, "https://api.flat.io/v2/scores/#{score_id}").to_return(status: 200, body: json_score_resp, headers: {})


    within '.scores' do
      within '#score-0' do
        click_on('My New Score')
      end
    end

    click_on('Submit Changes')

    expect(page).to have_current_path(users_dashboard_index_path)
  end
end
