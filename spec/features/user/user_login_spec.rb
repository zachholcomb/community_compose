require 'rails_helper'

RSpec.describe 'As a registered user' do
  it 'I can login' do
    json_user_resp = File.read('spec/fixtures/flat/user.json')
    stub_request(:get, "https://api.flat.io/v2/me").to_return(status: 200, body: json_user_resp, headers: {})

    json_score_resp = File.read('spec/fixtures/flat/create_score/users_scores_create_score.json')
    stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200, body: json_score_resp, headers: {})

    create(:user, email: 'zachholcombmusic@gmail.com')

    visit '/login'
    fill_in "Email",	with: "zachholcombmusic@gmail.com"
    click_on 'Log In'

    expect(page).to have_current_path('/users/dashboard')
  end
end
