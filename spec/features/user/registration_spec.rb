require 'rails_helper'

describe 'As a visitor' do
  scenario 'I can register' do
    json_user_resp = File.read('spec/fixtures/flat/user.json')
    stub_request(:get, "https://api.flat.io/v2/me").to_return(status: 200, body: json_user_resp, headers: {})
    json_score_resp = File.read('spec/fixtures/flat/user_scores.json')
    stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200, body: json_score_resp, headers: {})

    visit '/users/new?flat_id=5ecda8f84d6bf46345bcc4c9'
    fill_in 'Email', with: 'dog@example.com'
    fill_in 'Zip', with: '80005'
    click_button 'Register'

    user = User.last

    expect(current_path).to eq(users_dashboard_index_path)
    expect(page).to have_content("Welcome #{user.username} Registration Successful")
    expect(user.id).to_not be_nil
    expect(user.email).to eq('dog@example.com')
    expect(user.zip).to eq('80005')
  end
  scenario 'I need to fill out all required fields to register' do
    json_user_resp = File.read('spec/fixtures/flat/user.json')
    stub_request(:get, "https://api.flat.io/v2/me").to_return(status: 200, body: json_user_resp, headers: {})
    json_score_resp = File.read('spec/fixtures/flat/user_scores.json')
    stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200, body: json_score_resp, headers: {})

    visit '/users/new?flat_id=5ecda8f84d6bf46345bcc4c9'
    fill_in 'Email', with: 'dog@example.com'
    click_button 'Register'
    
    expect(current_path).to eq(users_path)
    expect(page).to have_content("Zip can't be blank")

    fill_in 'Email', with: 'dog@example.com'
    fill_in 'Zip', with: '80005'
    click_button 'Register'

    expect(current_path).to eq(users_dashboard_index_path)
  end
end
