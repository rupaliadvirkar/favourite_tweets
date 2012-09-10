class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_current_user, :except => [:login, :logout]
  before_filter :authenticate_user!, :except => :search
  
  #set the current_user to access in model
  def set_current_user
    User.current_user = current_user
  end
  
  #This is just to make sure, after authentication user should retrun to the search result
  def after_sign_in_path_for(resource)
    if params[:query]
      session["user_return_to"] = search_tweets_path(:query => params[:query])
    end
    super
  end
  
end
