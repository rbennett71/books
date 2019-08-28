class AddCreatedByToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :created_by, :string
  end
end
