require 'spec_helper'

describe "tweets/my_favourites" do
  before(:each) do
    @tweet = FactoryGirl.create(:tweet)
    @tweets = assign(:tweet, [@tweet])
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
