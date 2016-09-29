class RailwayStationsRoute < ActiveRecord::Base
  belongs_to :railway_station
  belongs_to :route

  # REVIEW: не разобрался до конца почему эта валидация срабатывает 2n раз при сохранении родительской модели (Route)
  # Позиции присваиваются верно, но сам метод отрабатывает больше раз чем нужно.
  before_validation :before_validation_assign_position, on: :create

  validates :route_id, uniqueness: { scope: :railway_station_id }
  validates :position, numericality: {
    only_integer: true,
    greater_than: 0,
    message: 'Позиция может быть задана только положительным числом!'
  }

  validates :position, uniqueness: {
    scope: :route_id,
    message: 'Такая позиция уже занята!'
  }

  validates :arrival_datetime, timeliness: {
    type: :datetime,
    invalid_datetime_message: 'Неправильный формат даты для поля arrival_datetime',
    allow_blank: true
  }

  validates :departure_datetime, timeliness: {
    type: :datetime,
    invalid_datetime_message: 'Неправильный формат даты для поля departure_datetime',
    allow_blank: true
  }

  validates :arrival_datetime, timeliness: {
    after: :now,
    after_message: 'Дата отправления должна быть в будущем!'
  }, allow_blank: true

  validates :departure_datetime, timeliness: {
    after: :now,
    after_message: 'Дата прибытия должна быть в будущем!'
  }, allow_blank: true

  validates :arrival_datetime, timeliness: {
    before: :departure_datetime,
    if: -> (railway_stations_route) do
      railway_stations_route.departure_datetime.present? && railway_stations_route.departure_datetime.present?
    end,
    before_message: 'Дата прибытия должна быть до даты отправления!'
  }

  private

  def before_validation_assign_position
    max_position = self.class.where(route_id: route_id).maximum('position')
    max_position ||= 0
    self.position = max_position + 1
  end
end
