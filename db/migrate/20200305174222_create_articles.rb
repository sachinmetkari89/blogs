class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :description
      t.integer :category_id, null: false
      t.integer :user_id, null: false
      t.string :state

      t.timestamps
    end
  end
end
