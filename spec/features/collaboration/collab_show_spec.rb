require 'rails_helper'

RSpec.describe 'Collaborators Features: ', type: :feature do
  describe 'As a user when I view a score ' do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user)
                                                  .and_return(@user)
      json_user_resp = File.read('spec/fixtures/flat/user.json')
      stub_request(:get, "https://api.flat.io/v2/me").to_return(status: 200,
                                                                body: json_user_resp,
                                                                headers: {})
      json_score_resp = File.read('spec/fixtures/flat/user_scores.json')
      stub_request(:get, "https://api.flat.io/v2/users/me/scores").to_return(status: 200,
                                                                             body: json_score_resp,
                                                                             headers: {})
      json_score_show_resp = File.read('spec/fixtures/flat/score_show.json')
      expected = nil
      File.open('spec/fixtures/flat/user_scores.json') do |file|
        file.each_line { |line| expected = JSON.parse(line, symbolize_names: true) }
      end
      stub_request(:get, "https://api.flat.io/v2/scores/#{expected[0][:id]}").to_return(status: 200,
                                                                                        body: json_score_show_resp,
                                                                                        headers: {})
      visit users_dashboard_index_path
      within('.scores') { click_link 'Funk' }
    end

    it 'I can see the collaborators on the score' do
      expect(current_path).to eq(scores_path)
      within('.collaborators') do
        expect(page.all("li").count).to eq(1)
        expect(page).to have_content('tylerpporter')
      end
    end

    it 'I see a button to request to collaborate if it is not my score' do
      within('.collaborators') do
        within ('.requests') do
          expect(page).to have_button('Request to collaborate on this score')
        end
      end
    end

    it 'I do not see a button if I am already a collaborator' do
      @user.update(username: 'tylerpporter')
      visit users_dashboard_index_path
      within('.scores') { click_link 'Funk' }

      within('.collaborators') do
        within ('.requests') do
          expect(page).to_not have_button('Request to collaborate on this score')
        end
      end
    end

    it 'I can request to collaborate & that request shows up for the owner' do
      collab_name = @user[:username]
      within('.collaborators') { click_button('Request to collaborate on this score') }


      expect(current_path).to eq(scores_path)

      visit users_dashboard_index_path
      @user.update(username: 'tylerpporter')

      within('.scores') { click_link 'Funk' }

      within('.collaborators') do
        within ('.requests') do
          expect(page).to have_content(collab_name)
          expect(page.all("li").count).to eq(1)
        end
      end
    end

    it 'I can request to collaborate and be rejected by the owner' do
      collab_name = @user[:username]
      within('.collaborators') { click_button('Request to collaborate on this score') }

      visit users_dashboard_index_path
      @user.update(username: 'tylerpporter')
      within('.scores') { click_link 'Funk'  }

      within('.collaborators') do
        within ('.requests') do
          click_button 'Reject'
        end
      end

      expect(current_path).to eq(scores_path)
      within('.collaborators') do
        expect(page).to_not have_content(collab_name)
        expect(page).to_not have_content('Requests to Collaborate')
      end
    end

    it 'I can request to collaborate and be approved by the owner' do
      collab_name = @user[:username]
      within('.collaborators') { click_button('Request to collaborate on this score') }

      visit users_dashboard_index_path
      @user.update(username: 'tylerpporter')
      within('.scores') { click_link 'Funk'  }

      within('.collaborators') do
        within ('.requests') do
          click_button 'Approve'
        end
      end

      expect(current_path).to eq(scores_path)
      within('.collaborators') do
        expect(page).to_not have_content('Requests to Collaborate')
        expect(page).to have_content(collab_name)
      end
    end
  end
end