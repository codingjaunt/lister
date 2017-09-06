class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.string :name
      t.references :user, foreign_key: true
    end
    add_index :lists, :name
  end
end
