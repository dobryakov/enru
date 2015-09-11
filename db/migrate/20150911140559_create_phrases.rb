class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.text :source
      t.text :translated
      t.belongs_to :feed, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
