class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :user_id
      t.integer :host_id
      t.integer :seconduser_id
      t.decimal :price,           :precision => 2, :scale => 2
      t.integer :status
      t.integer :amount

      t.timestamps
    end
  end
end
