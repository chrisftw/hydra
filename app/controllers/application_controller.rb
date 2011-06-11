class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_uber_page_site
  helper :all
  helper_method :current_user, :is_logged_in?, :requires_login, :empty_flash, :requires_site_admin_login, :is_site_admin?, :uber_page_site
  
  def is_logged_in?
    return true if current_user
    return false
  end
  
  def requires_login
    return true if current_user
    flash[:error] = "You must be logged in to do that."
    redirect_to login_path
  end
  
  def requires_site_admin_login
    return true if is_site_admin?
    flash[:error] = "You must be logged in to do that."
    redirect_to '/login'
  end
  
  def is_site_admin?
    return true if current_user && current_user.role_of([:super_user, :site_admin])
    return false
  end
  
  def empty_flash
    flash.delete(:notice)
    flash.delete(:error)
  end
  
  def uber_page_site
    $site
  end
  
  private
  def set_uber_page_site
    puts "SETTING $site"
    $site = session["site"]
  end
  
end
