class Train < ActiveRecord::Base
  belongs_to :route
  belongs_to :current_station, class_name: 'RailwayStation'
  has_many :tickets, dependent: :destroy
  has_many :carriages, dependent: :nullify

  validates :number, presence: true

  def count_seats(carriage_type, seats_type)
    raise ArgumentError unless Carriage::TYPES.include? carriage_type
    raise ArgumentError unless carriage_type::SEATS_TYPES_ATTRIBUTES_NAMES.include? seats_type

    carriages.where(type: carriage_type).sum(seats_type)
  end

  def update_carriages_positions
    carriages.ordered_by_position.each_with_index do |carriage, index|
      carriage.update_attribute(:position, index + 1)
    end
  end
end
