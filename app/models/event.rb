class Event < ActiveRecord::Base
  #self.primary_key = :event_id
  belongs_to :user
  has_many :reservations
  has_many :show, through: :reservations, source: :user #showに違和感を感じる
  #reservationsテーブルを経由して、reservationに紐付いたuserを取りに行く-> @event.showを使える
  has_many :comments

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  scope :active, -> { where('event_date >= ?', Date.today) }

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 250 }
  validates :event_date, presence: true
  validates :place, presence: true

  def active?
    DateTime.now.to_i < deadline.to_i
  end
end
