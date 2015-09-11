class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.text :url
      t.datetime :fetched_at

      t.timestamps null: false
    end
  end
end
