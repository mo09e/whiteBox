require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'Artistモデル機能', type: :model do
    before do
      @user = FactoryBot.create(:artist_user)
    end
    describe '情報登録のテスト' do
      context '名前について' do
        it '名前が空の場合バリデーションにひっかる' do
          artist = Artist.new(
                               name: '',
                               phone_number: '0120123456',
                               url: 'http://test.com',
                               images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                               note: 'test',
                               user_id: @user.id)
          expect(artist).not_to be_valid
        end
        it '名前が50文字以上の場合バリデーションにひっかる' do
          artist = Artist.new(
                               name: "a" * 51,
                               phone_number: '0120123456',
                               url: 'http://test.com',
                               images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                               note: 'test',
                               user_id: @user.id)
          expect(artist).not_to be_valid
        end
      end

      context '電話番号' do
        it '電話番号がなくてもバリデーションには引っかからない' do
          artist = Artist.new(
                               name: 'artist',
                               phone_number: '',
                               url: 'http://test.com',
                               images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                               note: 'test',
                               user_id: @user.id)
          expect(artist).to be_valid
        end
        it '電話番号が11文字以上の場合バリデーションにひっかる' do
          artist = Artist.new(
                               name: "artist",
                               phone_number: '0120123456789',
                               url: 'http://test.com',
                               images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                               note: 'test',
                               user_id: @user.id)
          expect(artist).not_to be_valid
        end
        it '電話番号にハイフンが入っている場合バリデーションにひっかる' do
          artist = Artist.new(
                               name: "artist",
                               phone_number: '03-123-456',
                               url: 'http://test.com',
                               images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                               note: 'test',
                               user_id: @user.id)
          expect(artist).not_to be_valid
        end
      end

      context 'URLについて' do
        it 'URLがなくてもバリデーションには引っかからない' do
          artist = Artist.new(
                               name: 'artist',
                               phone_number: '0123456789',
                               url: '',
                               images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                               note: 'test',
                               user_id: @user.id)
          expect(artist).to be_valid
        end
        it 'URLとして正しく認識されない場合バリデーションに引っかかる(http(s)://がない)' do
          artist = Artist.new(
                               name: "artist",
                               phone_number: '0123456789',
                               url: 'test.com',
                               images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                               note: 'test',
                               user_id: @user.id)
          expect(artist).not_to be_valid
        end
      end

      context 'imagesについて' do
        let(:images_path) { Rails.root.join('spec/fixtures/image_default.png') }
        let(:images) { Rack::Test::UploadedFile.new(images_path) }
        it 'imagesがなくてもバリデーションには引っかからない' do
          artist = Artist.new(
                               name: 'artist',
                               phone_number: '0123456789',
                               url: 'http://test.com',
                               images: [],
                               note: 'test',
                               user_id: @user.id)
          expect(artist).to be_valid
        end
        it 'imagesが5個以上の場合バリデーションに引っかかる' do
          artist = Artist.new(
                               name: "artist",
                               phone_number: '0123456789',
                               url: 'http://test.com',
                               images: [ images, images, images, images, images, images ],
                               note: 'test',
                               user_id: @user.id)
          expect(artist).not_to be_valid
        end
        it 'imagesが5個以内の場合バリデーションに引っかからない' do
          artist = Artist.new(
                               name: "artist",
                               phone_number: '0123456789',
                               url: 'http://test.com',
                               images: [ images, images, images, images ],
                               note: 'test',
                               user_id: @user.id)
          expect(artist).to be_valid
        end
      end

      context 'noteについて' do
        it 'noteが空の場合バリデーションにひっかる' do
          artist = Artist.new(
                               name: 'test',
                               phone_number: '0120123456',
                               url: 'http://test.com',
                               images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                               note: '',
                               user_id: @user.id)
          expect(artist).not_to be_valid
        end
        it '名前が800文字以上の場合バリデーションにひっかる' do
          artist = Artist.new(
                               name: 'test',
                               phone_number: '0120123456',
                               url: 'http://test.com',
                               images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                               note: 'a' *801,
                               user_id: @user.id)
          expect(artist).not_to be_valid
        end
      end

      context '全てが正しく入力された場合について' do
        it '情報登録のバリデーションにひっかからない' do
          artist = Artist.new(
                               name: 'test',
                               phone_number: '0120123456',
                               url: 'http://test.com',
                               images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                               note: 'test',
                               user_id: @user.id)
          expect(artist).to be_valid
        end
      end

    end
  end
end
