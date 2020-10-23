require 'rails_helper'
RSpec.describe 'カレンダー機能', type: :system do

  describe '新規作成機能' do
    before do
      FactoryBot.create(:artist_user)
      FactoryBot.create(:artist_user_info)
      FactoryBot.create(:gallery_user)
      FactoryBot.create(:gallery_user_info)
    end
    context 'アーティストはギャラリーのカレンダーに予約することができる' do
      it '予約をするとギャラリーのカレンダーで見れる' do
        visit new_user_session_path
        fill_in :user_email, with: 'a-test@ex.com'
        fill_in :user_password, with: 'password'
        click_on "Log in"
        click_on "Gallery"
        click_on "Macbeth"
        click_on "予約する"
        fill_in :reservation_title, with: 'The test'
        select '2020', from: :reservation_start_time_1i
        select '10', from: :reservation_start_time_2i
        select '31', from: :reservation_start_time_3i
        select '2020', from: :reservation_end_time_1i
        select '11', from: :reservation_end_time_2i
        select '3', from: :reservation_end_time_3i
        sleep 0.2
        click_on '登録する'
        expect(page).to have_content '予約を入れました'
        expect(page).to have_content 'The test'
      end
    end
  end

  describe '編集機能' do
    before do
      FactoryBot.create(:artist_user)
      FactoryBot.create(:artist_user_info)
      FactoryBot.create(:gallery_user)
      FactoryBot.create(:gallery_user_info)
      @reservation = FactoryBot.create(:reservation_test)
    end
    context 'ギャラリーができること' do
      it '予約を編集することができる' do
        visit new_user_session_path
        fill_in :user_email, with: 'g-test@ex.com'
        fill_in :user_password, with: 'password'
        click_on "Log in"
        click_on "Gallery"
        click_on "Macbeth"
        click_on "testtest"
        click_on "Edit"
        fill_in :reservation_title, with: 'The test'
        select '2020', from: :reservation_start_time_1i
        select '10', from: :reservation_start_time_2i
        select '30', from: :reservation_start_time_3i
        select '2020', from: :reservation_end_time_1i
        select '11', from: :reservation_end_time_2i
        select '3', from: :reservation_end_time_3i
        click_on '更新する'
        expect(page).to have_content '編集しました'
      end
      it '予約を編集することができる' do
        visit new_user_session_path
        fill_in :user_email, with: 'g-test@ex.com'
        fill_in :user_password, with: 'password'
        click_on "Log in"
        click_on "Gallery"
        click_on "Macbeth"
        sleep 0.5
        page.accept_confirm do
          click_on "Destroy"
        end
        expect(page).to have_content '削除しました'
      end
    end
  end

end
