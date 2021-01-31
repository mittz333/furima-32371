class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :zipcode, null: false
      t.integer :prefecture_id, null: false
      t.string :city, null: false
      t.string :street_number, null: false
      t.string :building
      t.string :tel, null: false
      t.references :purchase, foreign_key: true      

      t.timestamps
    end
  end
end
