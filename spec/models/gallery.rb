require 'rails_helper'

RSpec.describe Gallery, type: :model do
  describe 'Galleryモデル機能', type: :model do
    before do
      @user = FactoryBot.create(:gallery_user)
      layout_path = Rails.root.join('spec/fixtures/image_default.png')
      @layout = Rack::Test::UploadedFile.new(layout_path)
    end

    describe '情報登録のテスト' do

      context '名前について' do
        it '名前が空の場合バリデーションにひっかる' do
          gallery = Gallery.new(
                               name: '',
                               phone_number: '0120123456',
                               address: '東京都世田谷区',
                               rental_fee: 2,
                               lending_period: 1,
                               url: 'http://test.com',
                               images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                               layout: @layout,
                               note: 'test',
                               user_id: @user.id)
          expect(gallery).not_to be_valid
        end
        it '名前が50文字以上の場合バリデーションにひっかる' do
          gallery = Gallery.new(
                                name: "a" * 51,
                                phone_number: '0120123456',
                                address: '東京都世田谷区',
                                rental_fee: 2,
                                lending_period: 1,
                                url: 'http://test.com',
                                images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                                layout: @layout,
                                note: 'test',
                                user_id: @user.id)
           expect(gallery).not_to be_valid
         end
       end

      context '電話番号' do
        it '電話番号がなくてもバリデーションには引っかからない' do
          gallery = Gallery.new(
                                name: "g-test",
                                phone_number: '',
                                address: '東京都世田谷区',
                                rental_fee: 2,
                                lending_period: 1,
                                url: 'http://test.com',
                                images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                                layout: @layout,
                                note: 'test',
                                user_id: @user.id)
          expect(gallery).to be_valid
        end
        it '電話番号が11文字以上の場合バリデーションにひっかる' do
          gallery = Gallery.new(
                                name: "g-test",
                                phone_number: '012012345678',
                                address: '東京都世田谷区',
                                rental_fee: 2,
                                lending_period: 1,
                                url: 'http://test.com',
                                images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                                layout: @layout,
                                note: 'test',
                                user_id: @user.id)
          expect(gallery).not_to be_valid
        end
        it '電話番号にハイフンが入っている場合バリデーションにひっかる' do
          gallery = Gallery.new(
                                  name: "g-test",
                                  phone_number: '03-123-456',
                                  address: '東京都世田谷区',
                                  rental_fee: 2,
                                  lending_period: 1,
                                  url: 'http://test.com',
                                  images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                                  layout: @layout,
                                  note: 'test',
                                  user_id: @user.id)
          expect(gallery).not_to be_valid
        end
      end

      context 'URLについて' do
        it 'URLがなくてもバリデーションには引っかからない' do
          gallery = Gallery.new(
                                name: "g-test",
                                phone_number: '0120123456',
                                address: '東京都世田谷区',
                                rental_fee: 2,
                                lending_period: 1,
                                url: '',
                                images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                                layout: @layout,
                                note: 'test',
                                user_id: @user.id)
          expect(gallery).to be_valid
        end
        it 'URLとして正しく認識されない場合バリデーションに引っかかる(http(s)://がない)' do
          gallery = Gallery.new(
                                name: "g-test",
                                phone_number: '0120123456',
                                address: '東京都世田谷区',
                                rental_fee: 2,
                                lending_period: 1,
                                url: 'test.com',
                                images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                                layout: @layout,
                                note: 'test',
                                user_id: @user.id)
          expect(gallery).not_to be_valid
        end
      end

      context '住所について' do
        it '住所が空欄の場合バリデーションには引っかかる' do
          gallery = Gallery.new(
                                name: "g-test",
                                phone_number: '0120123456',
                                address: '',
                                rental_fee: 2,
                                lending_period: 1,
                                url: 'http://test.com',
                                images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                                layout: @layout,
                                note: 'test',
                                user_id: @user.id)
          expect(gallery).not_to be_valid
        end
        it '住所が300文字以上の場合バリデーションに引っかかる' do
          gallery = Gallery.new(
                                name: "g-test",
                                phone_number: '0120123456',
                                address: '東京都世田谷区'*300,
                                rental_fee: 2,
                                lending_period: 1,
                                url: 'test.com',
                                images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image_default.png'))],
                                layout: @layout,
                                note: 'test',
                                user_id: @user.id)
          expect(gallery).not_to be_valid
        end
      end

      context 'imagesについて' do
        let(:images_path) { Rails.root.join('spec/fixtures/image_default.png') }
        let(:images) { Rack::Test::UploadedFile.new(images_path) }
        it 'imagesがなくてもバリデーションには引っかからない' do
          gallery = Gallery.new(
                                name: "g-test",
                                phone_number: '0120123456',
                                address: '東京都世田谷区',
                                rental_fee: 2,
                                lending_period: 1,
                                url: '',
                                images: [],
                                layout: @layout,
                                note: 'test',
                                user_id: @user.id)
          expect(gallery).to be_valid
        end
        it 'imagesが5個以上の場合バリデーションに引っかかる' do
          gallery = Gallery.new(
                                name: "g-test",
                                phone_number: '0120123456',
                                address: '東京都世田谷区',
                                rental_fee: 2,
                                lending_period: 1,
                                url: 'http://test.com',
                                images: [images, images, images, images, images, images ],
                                layout: @layout,
                                note: 'test',
                                user_id: @user.id)
            expect(gallery).not_to be_valid
          end
          it 'imagesが5個以内の場合バリデーションに引っかからない' do
            gallery = Gallery.new(
                                  name: "g-test",
                                  phone_number: '0120123456',
                                  address: '東京都世田谷区',
                                  rental_fee: 2,
                                  lending_period: 1,
                                  url: 'http://test.com',
                                  images: [images, images, images, images, images ],
                                  layout: @layout,
                                  note: 'test',
                                  user_id: @user.id)
              expect(gallery).to be_valid
            end
          end

      context 'layoutについて' do
        let(:images_path) { Rails.root.join('spec/fixtures/image_default.png') }
        let(:images) { Rack::Test::UploadedFile.new(images_path) }
        it 'layoutがないとバリデーションに引っかかる' do
          gallery = Gallery.new(
                                name: "g-test",
                                phone_number: '0120123456',
                                address: '東京都世田谷区',
                                rental_fee: 2,
                                lending_period: 1,
                                url: 'http://test.com',
                                images: [images],
                                layout: '',
                                note: 'test',
                                user_id: @user.id)
          expect(gallery).not_to be_valid
        end
      end

      context 'layoutについて' do
        let(:images_path) { Rails.root.join('spec/fixtures/image_default.png') }
        let(:images) { Rack::Test::UploadedFile.new(images_path) }
        it 'noteが空欄の場合バリデーションに引っかかる' do
          gallery = Gallery.new(
                                name: "g-test",
                                phone_number: '0120123456',
                                address: '東京都世田谷区',
                                rental_fee: 2,
                                lending_period: 1,
                                url: 'http://test.com',
                                images: [images],
                                layout: @layout,
                                note: '',
                                user_id: @user.id)
          expect(gallery).not_to be_valid
        end
        it 'noteが800文字以上の場合バリデーションに引っかかる' do
          gallery = Gallery.new(
                                name: "g-test",
                                phone_number: '0120123456',
                                address: '東京都世田谷区',
                                rental_fee: 2,
                                lending_period: 1,
                                url: 'http://test.com',
                                images: [images],
                                layout: @layout,
                                note: 'a'*801,
                                user_id: @user.id)
          expect(gallery).not_to be_valid
        end
      end

      context '必須項目が全て正しく入力されていた場合' do
        let(:images_path) { Rails.root.join('spec/fixtures/image_default.png') }
        let(:images) { Rack::Test::UploadedFile.new(images_path) }
        it '情報が登録できる' do
          gallery = Gallery.new(
                                name: "g-test",
                                phone_number: '0120123456',
                                address: '東京都世田谷区',
                                rental_fee: 2,
                                lending_period: 1,
                                url: 'http://test.com',
                                images: [images],
                                layout: @layout,
                                note: 'test',
                                user_id: @user.id)
          expect(gallery).to be_valid
        end
      end

    end
  end
end
