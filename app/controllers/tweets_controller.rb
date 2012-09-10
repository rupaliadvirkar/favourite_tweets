class TweetsController < ApplicationController
  include TwitterApi
  def search
    if !params[:query].blank?
      @tweets = search_api(params[:query])
      @page_title = "Searched tweets for #{params[:query]}"
    else
      @page_title  = "Search tweets"
    end 
  end
  
  #This method will save the tweets selected by current user.
  def save_favourites
    current_user.tweets_to_be_added = params[:tweets_to_be_added]
    begin
      current_user.check_and_save_tweets
      redirect_to my_favourites_tweets_path(:query => params[:query])
    rescue
      render :action => :search, :notice => 'There occur an error while saving favoutite tweets. Please try again.'
    end  
  end
  
  #This method will return the favourites tweets of current user
  def my_favourites
    @tweets = current_user.tweets.order("twitter_created_at desc")
    @page_title = "Favourite tweets"
  end
end
