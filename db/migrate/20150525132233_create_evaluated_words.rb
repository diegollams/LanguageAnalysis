class CreateEvaluatedWords < ActiveRecord::Migration
  def change
    create_table :posts_words, id: false do    |t|
      t.belongs_to :word, index: true, foreign_key: true
      t.belongs_to :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
