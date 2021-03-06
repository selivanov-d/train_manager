class Carriage < ActiveRecord::Base
  belongs_to :train

  TYPES = [Carriage::Econom, Carriage::Business, Carriage::Luxurious, Carriage::Seating]

  validates :type, inclusion: { in: TYPES.map(&:to_s) }
  validates :type, presence: true
  validates :train_id, numericality: { only_integer: true, allow_blank: true }
  validates :position, uniqueness: { scope: :train_id, allow_nil: true }

  TYPES.each do |klass|
    klass::SEATS_TYPES_ATTRIBUTES_NAMES.each do |attr|
      validates attr, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    end
  end

  before_validation :before_validation_assign_position, if: :attached_to_train?
  before_validation :before_validation_remove_position, unless: :attached_to_train?
  after_update :after_update_update_train_carriages_positions
  after_destroy :after_destroy_update_train_carriages_positions

  scope :econom, -> { where(type: 'Carriage::Econom') }
  scope :business, -> { where(type: 'Carriage::Business') }
  scope :luxurious, -> { where(type: 'Carriage::Luxurious') }
  scope :seating, -> { where(type: 'Carriage::Seating') }
  scope :ordered_by, ->(position_from_head) { order(position: (position_from_head) ? :asc : :desc) }
  scope :ordered_by_position, -> { order(position: :asc) }

  def self.types
    TYPES.map { |carriage_type| [carriage_type::TYPE_NAME, carriage_type] }
  end

  def type_name
    self.class::TYPE_NAME
  end

  def max_position
    max_position_for_train(train_id)
  end

  def max_position_for_train(train_id)
    max_position = Carriage.where(train_id: train_id).maximum('position')
    max_position ||= 0
  end

  def class_name_in_snake_case
    self.class.to_s.underscore
  end

  private

  def attached_to_train?
    train_id.present?
  end

  def before_validation_assign_position
    self.position = max_position + 1
  end

  def before_validation_remove_position
    self.position = nil
  end

  def after_update_update_train_carriages_positions
    if persisted? && train_id_changed?
      ex_train_id = changes[:train_id][0]

      unless ex_train_id.nil?
        train = Train.find(ex_train_id)
        train.update_carriages_positions
      end
    end
  end

  def after_destroy_update_train_carriages_positions
    train.update_carriages_positions
  end
end
