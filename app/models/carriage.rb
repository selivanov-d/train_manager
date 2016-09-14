class Carriage < ActiveRecord::Base
  belongs_to :train

  TYPES = {
    econom: {
      name: 'Плацкартный',
      id: 1
    },
    business: {
      name: 'Купейный',
      id: 2
    }
  }

  PLACE_TYPES = [:upper, :bottom]

  validates :type_id, inclusion: { in: :type_ids }
  validates :train_id, numericality: { only_integer: true, allow_blank: true }
  validates :upper_seats, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :bottom_seats, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def type_name
    self.class.type_name_from_id(type_id)
  end

  def self.type_name_from_id(type_id)
    type = TYPES.values.find{ |type| type[:id] == type_id }
    type[:name]
  end

  def type_ids
    TYPES.values.map { |v| v[:id] }
  end
end
