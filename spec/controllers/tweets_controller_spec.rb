require 'spec_helper'

describe TweetsController do
  
  describe "GET 'search'" do
    it "should be successful" do
      get :search
      response.should be_success
      response.should render_template("search")
    end
  end
  
  describe "GET 'search'" do
    it "should be successful" do
      get :search, :query => 'ruby on rails'
      response.should be_success
      response.should render_template("search")
    end
  end
  
  describe "POST 'save_favourites'" do
    before(:each) do
      @attributes = ({:twitter_created_at => Time.now.to_s,
                     :from_user => "Test",
                     :from_user_id  => 1234,
                     :profile_image_url => "http://test1.com",
                     :text => "ruby on rails"}).to_s
    end
    it "should be successful for valid user (who is logged in)" do
      @user = FactoryGirl.create(:user)
      sign_in @user
      post :save_favourites, :tweets_to_be_added => [@attributes]
      @user.tweets.count.should == 1
      response.should be_redirect
      response.should redirect_to my_favourites_tweets_path()
    end

    it "should be unsuccessful for not logged in user" do
      @tweet = FactoryGirl.create(:tweet)
      post :save_favourites, :tweets_to_be_added => [@attributes]
      response.should_not be_success
    end
  end

   describe "GET 'my_favourites'" do
    it "should be successful for valid user (who is logged in)" do
      @user = FactoryGirl.create(:user)
      sign_in @user
      get :my_favourites
      response.should be_success
      response.should render_template("my_favourites")
    end  

    it "should be unsuccessful for not logged in user" do
      get :my_favourites
      response.should_not be_success
    end
  end
end
