class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id,                :null => false
      t.integer :host_id,                :null => false
      t.integer :amount,                :null => false
      t.decimal :price,                 :precision => 9, :scale => 2
      t.integer :status,                :null => false

      t.timestamps
    end
  end
end
