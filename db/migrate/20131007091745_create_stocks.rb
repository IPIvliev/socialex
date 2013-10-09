class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :buyer_id
      t.integer :seller_id, :default => 0
      t.integer :host_id
      t.integer :amount, :default => 100
      t.integer :price, :default => 100
      t.integer :status, :default => 0


      t.timestamps
    end
  end
end
