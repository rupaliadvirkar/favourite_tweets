require 'spec_helper'

describe User do  
  before(:each) do
    @user = FactoryGirl.create(:user)
    @tweet = FactoryGirl.create(:tweet)
    @user.tweets << @tweet
  end
  
  it "should check if the tweet is already present with user, if not saves it"  do    
    @user.tweets.count.should == 1
  end
  
  it "should check if the tweet is already present with user, if yes then dosenot save it"  do    
    user1 = FactoryGirl.create(:user1)
    lambda {FactoryGirl.create(:tweet)}.should raise_error(ActiveRecord::RecordInvalid)
    user1.tweets << @tweet
    user1.tweets.count.should == 1
    Tweet.all.length.should == 1
  end
end
