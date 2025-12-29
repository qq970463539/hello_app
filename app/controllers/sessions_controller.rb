class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        reset_session
        log_in user
    
        if params[:session][:remember_me] == "1"
          remember(user)
        else
          forget(user)
        end
    
        redirect_back_or user
      else
        flash[:warning] = "Account not activated. Check your email for the activation link."
        redirect_to root_url, status: :see_other
      end
    else
      flash.now[:danger] = "Invalid email/password combination"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
