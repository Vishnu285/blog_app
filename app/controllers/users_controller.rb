class UsersController < AuthenticationController
  skip_before_action :verify_login , :only => [:login]
  def login
    if request.get?
      if current_user
        flash[:notice] = 'You have already logged in'
        redirect_to '/'
        return
      end
    end
    if request.post?
      unless params[:user]
        flash[:error] = 'Invalid login'
        redirect_to "/login"
        return
      end
      user = User.authenticate(params[:user])
      unless user
        flash[:error] = 'Credentials are wrong'
        redirect_to "/login"
        return
      end
      login_as user
      redirect_to '/'
      return
    end
  end
  def logout
    reset_session
    redirect_to '/login'
  end
end