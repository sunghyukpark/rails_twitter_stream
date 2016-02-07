class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :word
      t.integer :frequency

      t.timestamps null: false
    end
  end
end
