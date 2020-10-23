require 'rails_helper'
RSpec.describe 'ギャラリーについて', type: :system do
  describe '検索機能' do
    before do
      FactoryBot.create(:gallery_user)
      FactoryBot.create(:gallery_user_info)
      FactoryBot.create(:gallery_second_user)
      FactoryBot.create(:gallery_user_second_info)
      FactoryBot.create(:gallery_third_user)
      FactoryBot.create(:gallery_user_third_info)
    end

    context 'タイトルであいまい検索をした場合' do
      it "タイトルで絞り込まれる" do
        visit galleries_path
        fill_in :q_name_cont, with: 'King'
        click_on 'Search'
        expect(page).to have_content 'King Lear'
      end
    end

    context 'rental_feeでソートした場合' do
      it "一度押すと安い順になる" do
        visit galleries_path
        click_on 'rental_fee'
        sleep 0.3
        rental_fee = all('.g_rental_fee')
        expect(rental_fee[0]).to have_content '１万円以内'
      end
    end

    context 'lending_periodでソートした場合' do
      it "一度押すと単位の短い順になる" do
        visit galleries_path
        click_on 'lending_period'
        sleep 0.3
        lending_period = all('.g_lending_period')
        expect(lending_period[0]).to have_content '3日間'
        expect(lending_period[1]).to have_content '5日間'
      end
    end

  end
end
