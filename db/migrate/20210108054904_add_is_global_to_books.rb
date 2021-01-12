class AddIsGlobalToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :is_global, :boolean, default:false
  end
end
