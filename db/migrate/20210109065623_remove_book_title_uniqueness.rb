class RemoveBookTitleUniqueness < ActiveRecord::Migration[6.1]
  def change
    remove_index :books, :title, unique: true
  end
end
