require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Userモデル機能', type: :model do

    describe 'SignUpのテスト' do
      context 'Emailについて' do
        it 'Emailが空の場合バリデーションにひっかる' do
          user = User.new(name: 'test', email: '', password: 'password', password_confirmation: 'password')
          expect(user).not_to be_valid
        end
        it 'Emailアドレスと認識されない場合バリデーションに引っかかる' do
          user = User.new(name: 'test', email: '0a0a0', password: 'password', password_confirmation: 'password')
          expect(user).not_to be_valid
        end
      end
      context 'Passwordについて' do
        it 'Passwordが空の場合バリデーションにひっかる' do
          user = User.new(name: 'test', email: 'test@ex.com', password: '', password_confirmation: 'password')
          expect(user).not_to be_valid
        end
        it 'password_confirmationが空の場合バリデーションに引っかかる' do
          user = User.new(name: 'test', email: '0a0a0', password: 'password', password_confirmation: '')
          expect(user).not_to be_valid
        end
        it 'passwordとpassword_confirmationが一致しない場合バリデーションに引っかかる' do
          user = User.new(name: 'test', email: '0a0a0', password: 'password', password_confirmation: 'possword')
          expect(user).not_to be_valid
        end
      end
      context '必須項目が全て入力されている場合' do
        it 'バリデーションに引っかからない' do
          user = User.new(name: 'test', email: 'test@ex.com', password: 'password', password_confirmation: 'password')
          expect(user).to be_valid
        end
      end
    end

  end
end
