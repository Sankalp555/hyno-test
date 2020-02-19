class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|

      t.text :message
      t.references :user, index: true
      t.timestamps
    end
  end
end
