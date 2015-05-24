class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.float :rate,default: 0
      t.integer :evaluated, default: 0

      t.timestamps null: false
    end
  end
end
