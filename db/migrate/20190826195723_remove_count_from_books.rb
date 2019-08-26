class RemoveCountFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :count, :integer
  end
end


