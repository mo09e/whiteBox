## WhiteBox
### コンセプト
- ハコ、人、繋がる
### 概要
- ギャラリーと作家のマッチングアプリ。
- ギャラリーを地区別、利用期間毎などで検索する事ができます。
- 作家はギャラリーに予約をする事ができ、ギャラリーはその予定を編集する事ができます。

### バージョン情報
- Ruby 2.6.5
- Ruby on Rails 5.2.4.3
- DateBase postgresql

### 機能一覧
- ログイン機能
- ギャラリー、作家一覧閲覧、検索機能
- 予約機能
- お気に入り機能
- DM機能

### 各設計情報
- **[カタログ設計、テーブル定義、ER図](https://docs.google.com/spreadsheets/d/1dX859nKapVFsoUpK8391ErymyvPgm8Y2PKLTsmy9C5o/edit?usp=sharing)**
- **[画面遷移、ワイヤーフレーム](https://docs.google.com/spreadsheets/d/1XAqCJpqnRi7nOU5GMxm3GqjlTEMqY-tQ5tEwwfY6WkY/edit?usp=sharing)**

### 使用予定Gem
- devise
- carrierwave
- mini_magick
- admin
- simple_calendar
- Ransack

- **就業Termから少なくとも2つ**
1. devise
1. 一対一のメッセージ機能
- **カリキュラム外から１つ以上**
1. simple_calendar : カレンダー機能
1. Ransack : 検索機能
