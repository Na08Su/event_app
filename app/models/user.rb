class User < ActiveRecord::Base
  #self.primary_key = :user_id
  has_many :events
  has_many :reservations, dependent: :destroy
  has_many :comments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true
end
