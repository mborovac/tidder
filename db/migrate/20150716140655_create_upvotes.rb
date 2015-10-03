class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.integer :post_id,         null: false, default: ""
      t.integer :upvotes_number,  null: false, default: ""

      t.timestamps null: false
    end
  end
end
