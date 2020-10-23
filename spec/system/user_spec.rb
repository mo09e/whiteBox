require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do
  describe '新規作成機能' do
    context '作家ユーザーを新規作成した場合' do
      it '作成したユーザーが表示される' do
        visit  new_user_registration_path
        fill_in :user_name, with: 'a-user'
        fill_in :user_email, with: 'a-user@test.com'
        attach_file('user_avatar', 'app/assets/images/fallback/default_avatar.png')
        fill_in :user_password, with: 'password'
        fill_in :user_password_confirmation, with: 'password'
        click_on "Sign up"
        expect(page).to have_content '作家情報を登録する'
      end
      it '続けて詳細情報を登録した場合' do
        visit  new_user_registration_path
        fill_in :user_name, with: 'a-user'
        fill_in :user_email, with: 'a-user@test.com'
        attach_file('user_avatar', 'app/assets/images/fallback/default_avatar.png')
        fill_in :user_password, with: 'password'
        fill_in :user_password_confirmation, with: 'password'
        click_on "Sign up"
        visit  new_artist_path
        fill_in :artist_name, with: 'a-user-artist'
        fill_in :artist_phone_number, with: '0123456789'
        fill_in :artist_url, with: 'http://ex.test.com'
        fill_in :artist_note, with: '作家だよ'
        attach_file('artist_images', 'app/assets/images/fallback/default.png')
        click_on "登録"
        expect(page).to have_content 'a-user'
      end
    end
    context 'ギャラリー所有者ユーザーを新規作成した場合' do
      it '作成したユーザーが表示される' do
        visit  new_user_registration_path
        fill_in :user_name, with: 'g-user'
        fill_in :user_email, with: 'g-user@test.com'
        attach_file('user_avatar', 'app/assets/images/fallback/default_avatar.png')
        fill_in :user_password, with: 'password'
        fill_in :user_password_confirmation, with: 'password'
        choose :user_gallery_owner_yes
        click_on "Sign up"
        expect(page).to have_content 'ギャラリー情報を登録する'
      end
      it '作成したユーザーが表示される' do
        visit  new_user_registration_path
        fill_in :user_name, with: 'g-user'
        fill_in :user_email, with: 'g-user@test.com'
        attach_file('user_avatar', 'app/assets/images/fallback/default_avatar.png')
        fill_in :user_password, with: 'password'
        fill_in :user_password_confirmation, with: 'password'
        choose :user_gallery_owner_yes
        click_on "Sign up"
        visit  new_gallery_path
        fill_in :gallery_name, with: 'g-user-gallery'
        fill_in :gallery_phone_number, with: '0123456789'
        fill_in :gallery_address, with: '東京都渋谷区'
        fill_in :gallery_url, with: 'http://ex.test.com'
        select '１万円以内', from: :gallery_rental_fee
        select '3日間', from: :gallery_lending_period
        fill_in :gallery_note, with: 'ギャラリーだよ'
        attach_file('gallery_layout', 'app/assets/images/fallback/default.png')
        attach_file('gallery_images', 'app/assets/images/gallery-w.jpg')
        click_on "登録"
        expect(page).to have_content 'g-user'
      end
    end
  end

  describe 'ログイン機能' do
    before do
      FactoryBot.create(:artist_user)
    end
    context 'ログインした場合' do
      it 'ログインすることができる' do
        visit new_user_session_path
        fill_in :user_email, with: 'a-test@ex.com'
        fill_in :user_password, with: 'password'
        click_on "Log in"
        expect(page).to have_content 'Mypage'
      end
      it 'マイページにアクセスできる' do
        visit new_user_session_path
        fill_in :user_email, with: 'a-test@ex.com'
        fill_in :user_password, with: 'password'
        click_on "Log in"
        click_on "Mypage"
        expect(page).to have_content 'favorite List'
      end
      it 'ログアウトができる' do
        visit new_user_session_path
        fill_in :user_email, with: 'a-test@ex.com'
        fill_in :user_password, with: 'password'
        click_on "Log in"
        click_on "Logout"
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '未ログインユーザーについて' do
    before do
      FactoryBot.create(:artist_user)
      FactoryBot.create(:artist_user_info)
      FactoryBot.create(:gallery_user)
      FactoryBot.create(:gallery_user_info)
    end
    context 'トップページ・詳細ページまで見ることができる' do
      it 'トップページで一覧を見ることができる' do
        visit root_path
        expect(page).to have_content 'Hamlet'
      end
      it 'アーティストの詳細を見ることができる' do
        visit root_path
        click_on "Hamlet"
        expect(page).to have_content 'Brevity is the soul of wit.'
      end
      it 'ギャラリーの詳細を見ることができる' do
        visit root_path
        click_on "Macbeth"
        expect(page).to have_content 'http://testtest.test.com'
      end
    end
  end
end
