class AddSellerToProducts < ActiveRecord::Migration[7.2]
  def change
    add_reference :products, :seller, foreign_key: true
  end
end
