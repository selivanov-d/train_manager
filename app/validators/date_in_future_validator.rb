class DateInFutureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if Time.zone.now >= value
      record.errors.add attribute,
        (options[:message] || "Date specified in #{attribute} can't be in the past")
    end
  end
end
