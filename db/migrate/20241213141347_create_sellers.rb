class CreateSellers < ActiveRecord::Migration[7.2]
  def change
    create_table :sellers do |t|
      t.string :name
      t.decimal :rating
      t.string :policy
      t.text :additional_info

      t.timestamps
    end
  end
end
