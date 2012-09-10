class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :from_user
      t.integer :from_user_id
      t.string :profile_image_url
      t.string :text
      t.datetime :twitter_created_at
      t.timestamps
    end
    add_index :tweets, :from_user_id, :name =>'idx_tweets_from_user_id'
    add_index :tweets, :twitter_created_at, :name => 'idx_tweets_twitter_created_at'
  end
end
