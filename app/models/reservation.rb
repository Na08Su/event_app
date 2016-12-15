class Reservation < ActiveRecord::Base
  self.primary_keys = :user_id, :event_id
  belongs_to :user
  belongs_to :event
end
