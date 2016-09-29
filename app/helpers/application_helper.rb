module ApplicationHelper
  def get_errors_as_array_of_strings_for(model)
    model.errors.messages.values.flatten
  end
end
