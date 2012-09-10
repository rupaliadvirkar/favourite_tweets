require 'spec_helper'

describe Tweet do
  before(:each) do
    @tweet = FactoryGirl.create(:tweet)
  end
  
  it "should be invalid without from_user_id" do
    @tweet.from_user_id = nil
    @tweet.should_not be_valid
  end

  it "should be invalid without created_at" do
    @tweet.twitter_created_at = nil
    @tweet.should_not be_valid
  end
  
  it "should be invalid tweet which is duplicate with respect to scope of form_user" do
    dup_tweet = FactoryGirl.build(:tweet)
    dup_tweet.should_not be_valid
  end  
end
