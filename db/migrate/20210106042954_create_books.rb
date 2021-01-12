class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }
      t.string :title, null: false
      t.timestamps
    end
    add_index :books, :title, unique: true
  end
end
