require 'rails_helper'
RSpec.describe 'DM機能', type: :system do
  describe 'メッセージ機能について' do
    before do
      FactoryBot.create(:artist_user)
      FactoryBot.create(:artist_user_info)
      FactoryBot.create(:gallery_user)
      FactoryBot.create(:gallery_user_info)
    end
    context 'ユーザーは一対一でメッセージのやりとりをすることができる' do
      it '送信したメッセージが見れる' do
        visit new_user_session_path
        fill_in :user_email, with: 'a-test@ex.com'
        fill_in :user_password, with: 'password'
        click_on "Log in"
        click_on "Gallery"
        click_on "Macbeth"
        click_on "Send DM"
        fill_in :message_content, with: 'Hello world!'
        click_on "Send"
        expect(page).not_to have_content 'Michelangelo'
      end
    end
  end
end
