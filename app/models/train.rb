class Train < ActiveRecord::Base
  belongs_to :route
  belongs_to :current_station, class_name: 'RailwayStation'
  has_many :tickets
  has_many :carriages
  has_many :econom_carriages, -> { where(type_id: Carriage::TYPES[:econom][:id]) }, class_name: 'Carriage'
  has_many :business_carriages, -> { where(type_id: Carriage::TYPES[:business][:id]) }, class_name: 'Carriage'

  validates :number, presence: true

  def count_seats(type, place)
    raise ArgumentError unless Carriage::TYPES.keys.include? type
    raise ArgumentError unless Carriage::PLACE_TYPES.include? place

    send(:"#{type}_carriages").map { |s| s.send(:"#{place}_seats") }.reduce(:+)
  end
end
