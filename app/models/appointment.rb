class Appointment < ApplicationRecord
  belongs_to :schedule
  validates :start_time, :end_time, presence: true
end
