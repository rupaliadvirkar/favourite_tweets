class CreateUsersTweets < ActiveRecord::Migration
  def up
    create_table :users_tweets , :id => false do |t|
      t.references :user
      t.references :tweet
    end
    add_index :users_tweets, [:user_id,:tweet_id], :unique => true
  end

  def down
  end
end
