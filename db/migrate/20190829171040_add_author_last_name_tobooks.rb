class AddAuthorLastNameTobooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :author_last_name, :string
  end
end
