require 'rails_helper'

describe 'As a registered user' do
  xscenario 'I can update my zip' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user)
                                                .and_return(user)
    json_user_resp = File.read('spec/fixtures/flat/user.json')
    stub_request(:get, "https://api.flat.io/v2/me").to_return(status: 200, body: json_user_resp, headers: {})
    json_score_resp = File.read('spec/fixtures/flat/user_scores.json')
    stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200, body: json_score_resp, headers: {})
    visit users_dashboard_index_path
    click_link 'Change My Location'

    expect(current_path).to eq(edit_user_path(user.id))
  end
end
