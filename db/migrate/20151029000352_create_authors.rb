class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :handle
      t.string :url

      t.timestamps null: false
    end
  end
end
