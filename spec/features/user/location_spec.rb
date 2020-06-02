require 'rails_helper'

describe 'As a registered user' do
  scenario 'I can update my zip' do
    user = create(:user, zip: '80004')
    allow_any_instance_of(ApplicationController).to receive(:current_user)
                                                .and_return(user)
    json_user_resp = File.read('spec/fixtures/flat/user.json')
    stub_request(:get, "https://api.flat.io/v2/me").to_return(status: 200, body: json_user_resp, headers: {})
    json_score_resp = File.read('spec/fixtures/flat/user_scores.json')
    stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200, body: json_score_resp, headers: {})
    visit users_dashboard_index_path
    click_link 'Change My Location'

    expect(user.zip).to eq('80004')
    expect(current_path).to eq(users_edit_location_path(user.id))

    fill_in :zip, with: '80005'
    click_button 'Update Location'
    user.reload

    expect(current_path).to eq(users_dashboard_index_path)
    expect(page).to have_content('Successfully updated location!')
    expect(user.zip).to eq('80005')
  end
end
