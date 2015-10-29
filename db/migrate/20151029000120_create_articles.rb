class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :url
      t.string :title
      t.integer :author_id
      t.integer :parent_id

      t.timestamps null: false
    end
  end
end
