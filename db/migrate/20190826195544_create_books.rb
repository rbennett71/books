class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn
      t.integer :count
      t.text :description

      t.timestamps
    end
    add_index :books, :title
  end
end
