require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'Reservationモデル機能', type: :model do
    before do
      FactoryBot.create(:artist_user)
      @artist = FactoryBot.create(:artist_user_info)
      FactoryBot.create(:gallery_user)
      @gallery = FactoryBot.create(:gallery_user_info)
    end

    describe '予約機能' do
      context 'titleについて' do
        it 'titleが空の場合バリデーションにひっかる' do
          reservation = Reservation.new(
                                        title: '',
                                        start_time: Date.today.since(1.weeks),
                                        end_time: Date.today.since(1.weeks),
                                        artist_id: @artist.id,
                                        gallery_id: @gallery.id)
          expect(reservation).not_to be_valid
        end
        it 'titleが30文字以上の場合バリデーションにひっかる' do
          reservation = Reservation.new(
                                        title: 'a' *31,
                                        start_time: Date.today.since(1.weeks),
                                        end_time: Date.today.since(1.weeks),
                                        artist_id: @artist.id,
                                        gallery_id: @gallery.id)
          expect(reservation).not_to be_valid
        end
      end

        context '日付について' do
          it 'start_timeが１週間後以降ではない場合バリデーションに引っかかる' do
            reservation = Reservation.new(
                                          title: 'title',
                                          start_time: Date.today,
                                          end_time: Date.today.since(1.weeks),
                                          artist_id: @artist.id,
                                          gallery_id: @gallery.id)
            expect(reservation).not_to be_valid
          end
          it 'end_timeがstart_timeよりも前の場合バリデーションに引っかかる' do
            reservation = Reservation.new(
                                          title: 'title',
                                          start_time: Date.today.since(1.weeks),
                                          end_time: Date.today,
                                          artist_id: @artist.id,
                                          gallery_id: @gallery.id)
            expect(reservation).not_to be_valid
          end
        end

        context '情報を全て正しく入力した場合' do
          it 'バリデーションに引っかからず登録できる' do
            reservation = Reservation.new(
                                          title: 'title',
                                          start_time: Date.today.since(1.weeks),
                                          end_time: Date.today.since(2.weeks),
                                          artist_id: @artist.id,
                                          gallery_id: @gallery.id)
            expect(reservation).to be_valid
          end
        end

    end
  end
end
