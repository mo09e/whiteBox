class Reservation < ApplicationRecord
  belongs_to :artist
  belongs_to :gallery, optional: true
  validates :title, presence:true, length: { maximum: 30 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :date_before_start, :start_end_check

  def date_before_start
    if start_time < Date.today.since(1.weeks)
      errors.add(:start_time, "予約開始日は１週間後以降のものを選択してください")
    end
  end
  def start_end_check
    errors.add(:end_date, "予約終了日は開始日の同日、あるいは開始日以降に設定してください。") unless
    self.start_time <= self.end_time
  end
end
