class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_user_path(current_user)
    else
      search_path
    end
  end
end
