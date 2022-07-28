class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    user_info = request.env['omniauth.auth']
    if user_info.info.email.nil?
      flash[:notice] = "couldn't get valid email"
      redirect_to :root
    else
      if user_info.provider == 'developer'
        user = developer
      else
        if user_in_db?(user_info)
          update_user(user_info)
          user = User.find_by(provider_id: user_info.uid)
        else
          user = create_new_user(user_info)
        end
      end

      store_user(user.id)
      redirect_to "/youtubefavs"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

  def store_user(id)
    session[:user_id] = id
  end

  def developer
    Users.developer
  end

  def user_in_db?(user_info)
    Users.user_in_db?(user_info.uid)
  end

  def update_user(user_info)
    Users.update_user(user_info)
  end

  def create_new_user(user_info)
    Users.create_new_user(user_info)
  end

  def failure
    redirect_to :root
  end
end
