class StaticPagesController < ApplicationController
  def root
    session[:user_id] = nil
  end
end
