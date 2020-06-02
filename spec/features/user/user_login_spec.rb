require 'rails_helper'

RSpec.describe 'As a registered user' do
  xit 'I can login' do
    json_user_resp = File.read('spec/fixtures/flat/user.json')
    stub_request(:get, "https://api.flat.io/v2/me").to_return(status: 200, body: json_user_resp, headers: {})

    json_score_resp = File.read('spec/fixtures/flat/create_score/users_scores_create_score.json')
    stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200, body: json_score_resp, headers: {})

    create(:user, email: 'zachholcombmusic@gmail.com')

    visit '/'
    click_link 'Login/Register'

    # fill_in "Email",	with: "zachholcombmusic@gmail.com"
    # fill_in "Zip",	with: "80005"
    # click_on 'Log In'

    expect(current_path).to eq(users_dashboard_index_path)
  end
end
