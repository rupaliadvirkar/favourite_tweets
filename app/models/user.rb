class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  #HABTM tweets
  has_and_belongs_to_many :tweets, :join_table => 'users_tweets'
  
  #This is to fetched all the selected tweets need to save.
  attr_accessor :tweets_to_be_added
  
  #This mothod will do :-
  #check for users existing favourites. If already selected tweet is already present then dont save
  #while saving tweet which is new, then check for uniqueness of it
  #if that tweet is present already the just add it to user favourites
  #if that tweet is not present then create it and add it to user favourites
  def check_and_save_tweets
    user_fav_tweets = self.tweets
    User.transaction do
      self.tweets_to_be_added.each do |add_tweet|
        add_tweet = eval(add_tweet)
        existing_tweet = user_fav_tweets.detect{|tweet| tweet.from_user_id == add_tweet[:from_user_id] and tweet.twitter_created_at == add_tweet[:twitter_created_at]}
        if !existing_tweet
          new_tweet = Tweet.new(:twitter_created_at => add_tweet[:twitter_created_at],
                                :from_user => add_tweet[:from_user],
                                :from_user_id => add_tweet[:from_user_id],
                                :profile_image_url => add_tweet[:profile_image_url],
                                :text => add_tweet[:text])
          if new_tweet.valid?
            self.tweets << new_tweet
          else
            #This query result will be fetched from cache
            self.tweets << new_tweet.search_for_duplicate_tweet
          end                       
        end
      end      
    end
  end
  
  #This to avail the current_user in model. Thread safe is just to avoid overriding.
  class << self
    def current_user=(user)
      Thread.current[:current_user] = user
    end
    
    def current_user
      Thread.current[:current_user]
    end
  end  
end
