class ScheduleSerializer < ActiveModel::Serializer
  attributes :id
  has_many :appointments
end
