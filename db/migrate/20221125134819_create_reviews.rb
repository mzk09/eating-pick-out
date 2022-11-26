class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.integer :customer_id, null: false
      t.integer :restaurant_id, null: false
      t.text :comment,  null: false
      #5段階評価のためのテーブル
      t.float :rate,  null: false,  default: 0

      t.timestamps
    end
  end
end
