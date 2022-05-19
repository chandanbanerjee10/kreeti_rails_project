class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :name
      t.string :post_description
      t.string :username
      t.integer :phone_number
      t.string :city

      t.timestamps
    end
  end
end
