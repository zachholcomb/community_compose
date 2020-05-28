require 'rails_helper'

RSpec.describe 'As a User', type: :feature do
  it 'I can see a score show page' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user)
                                                  .and_return(user)
      json_score_resp = File.read('spec/fixtures/flat/score_show.json')
     
      expected = nil
      File.open('spec/fixtures/flat/user_scores.json') do |file|
        file.each_line do |line|
          expected = JSON.parse(line, symbolize_names: true)
        end
      end
      
      stub_request(:get, "https://api.flat.io/v2/scores/#{expected[0][:id]}").to_return(status: 200, body: json_score_resp, headers: {})
      
      visit score_path

      expect(page).to have_content(expected[0][:title])

  end
end