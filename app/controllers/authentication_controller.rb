class AuthenticationController < ApplicationController
  protect_from_forgery with: :exception
  before_action :verify_login
  before_action :current_user
  
  def login_as(user)
    raise "No user passed" unless user
    self.set_current_user(user)
  end  

  def set_current_user(user)
    reset_session
    session['user_id'] = user.id
    @current_user = user
  end

  def current_user
    user = nil
    @current_user = (
      if session['user_id']
        user = User.find_by_id(session['user_id'])
      end
      user
    )
  end

  def verify_login
    if !current_user
      flash[:error] = "You must login to access this page"
      redirect_to '/login'
    end
  end

  def reset_user_session
    reset_session
    redirect_to '/login'
  end
end