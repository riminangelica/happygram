class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.text :description
      t.string :photo
      t.integer :user_id

      t.timestamps
    end
  end
end
