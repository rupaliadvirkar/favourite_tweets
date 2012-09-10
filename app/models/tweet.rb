class Tweet < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => 'users_tweets'
  
  validate :check_uniqueness_with_scope_of_from_user
  
  validates :from_user_id, :presence => true
  
  validates :twitter_created_at, :presence => true
  
  #uniquness of tweet
  def check_uniqueness_with_scope_of_from_user
    self.errors.add(:from_user_id, 'Tweet already exists') if self.search_for_duplicate_tweet
  end
  
  #serach for duplicate tweet
  def search_for_duplicate_tweet
    tweet = Tweet.where('twitter_created_at = ? AND from_user_id = ?', self.twitter_created_at, self.from_user_id).first
    tweet
  end  
end
