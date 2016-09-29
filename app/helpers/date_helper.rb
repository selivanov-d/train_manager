module DateHelper
  def time_object_from_params_from_datetime_params(params_hash)
    Time.new(
      params_hash['(1i)'].to_i,
      params_hash['(2i)'].to_i,
      params_hash['(3i)'].to_i,
      params_hash['(4i)'].to_i,
      params_hash['(5i)'].to_i
    )
  rescue
     false
  end
end
