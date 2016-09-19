class Carriage < ActiveRecord::Base
  belongs_to :train

  # OPTIMIZE: Не нашёл лучшего способа получить дочерние классы. Метод subclasses возвращает подклассы только если они хоть раз были инициализированы. Можно ещё опцией Rails.application.eager_load! принудительно загрузить все модели, но не уверен, что это правильный путь.
  TYPES = [EconomClassCarriage, BusinessClassCarriage, LuxuriousClassCarriage, SeatingOnlyClassCarriage]

  validates :type, inclusion: { in: TYPES.map(&:to_s) }
  validates :type, presence: true
  validates :train_id, numericality: { only_integer: true, allow_blank: true }
  validates :position, uniqueness: { scope: :train_id, allow_nil: true }

  TYPES.each do |klass|
    klass::SEATS_TYPES_ATTRIBUTES_NAMES.each do |attr|
      validates attr, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    end
  end

  before_validation :assign_position, if: :attached_to_train?
  before_validation :remove_position, unless: :attached_to_train?
  after_update :update_train_carriages_positions

  scope :econom_class, -> { where(type: 'EconomClassCarriage') }
  scope :business_class, -> { where(type: 'BusinessClassCarriage') }
  scope :luxurious_class, -> { where(type: 'LuxuriousClassCarriage') }
  scope :seating_only_class, -> { where(type: 'SeatingOnlyClassCarriage') }
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
    max_position
  end

  def class_name_in_snake_case
    self.class.to_s.underscore
  end

  private

  def attached_to_train?
    train_id.present?
  end

  def assign_position
    self.position = max_position + 1
  end

  def remove_position
    self.position = nil
  end

  def update_train_carriages_positions
    if !new_record? && train_id_changed?
      ex_train_id = changes[:train_id][0]

      unless ex_train_id.nil?
        train = Train.find(ex_train_id)

        train.update_carriages_positions
      end
    end
  end
end
