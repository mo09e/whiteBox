require 'rails_helper'
RSpec.describe Message, type: :model do
  describe 'Messageモデル機能', type: :model do
    before do
      @user = FactoryBot.create(:artist_user)
    end

    describe '1対1のメッセージ機能について' do
      context 'contentについて' do
        it 'contentが空の場合バリデーションにひっかる' do
          message = Message.new(
                                content: "",
                                user_id: @user.id,
                                room_id: Room.last)
          expect(message).not_to be_valid
        end
        it 'contentが200文字以上の場合バリデーションにひっかる' do
          message = Message.new(
                                content: "a" *201,
                                user_id: @user.id,
                                room_id: Room.last)
          expect(message).not_to be_valid
        end
      end
    end
  end
end
