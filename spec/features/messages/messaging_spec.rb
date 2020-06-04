require 'rails_helper'

describe 'As a registered user' do
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user)
                                            .and_return(@user1)

    json_user_resp = File.read('spec/fixtures/flat/user.json')
    stub_request(:get, "https://api.flat.io/v2/me").to_return(status: 200,
                                                              body: json_user_resp,
                                                              headers: {})
                                                              
    json_score_resp = File.read('spec/fixtures/flat/user_scores.json')
    stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200,
                                                                            body: json_score_resp,
                                                                            headers: {})
  end
  it 'I can send a private message to another register user' do
    visit users_dashboard_index_path
    expect(page).to have_link('Messages')
    click_link 'Messages'
  end
end