class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :phrase, index: true, foreign_key: true
      t.text :translated
      t.float :score

      t.timestamps null: false
    end
  end
end
