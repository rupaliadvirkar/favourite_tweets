require 'spec_helper'

describe "tweets/search" do
  before(:each) do
    tweet = FactoryGirl.create(:tweet)
    assign(:tweets, [tweet])
  end

  it "should render the list of tweets without facility to mark favourite non user" do
    render
    rendered.should_not have_selector('input[type="checkbox"]')
  end

  it "should render the list of tweets with facility to mark favourite for logged in user" do
    @user = stub_model(User, :email => 'test1@tcs.com', :password => '1234')
    sign_in @user
    current_user = @user
    view.stub!(:current_user).and_return @user
    assign(:currrnet_user, @user)
    render
    rendered.should have_selector('input[type="checkbox"]')
  end

end
