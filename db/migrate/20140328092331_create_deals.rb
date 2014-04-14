class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :user_id
      t.integer :host_id
      t.integer :seconduser_id
      t.decimal :price,           :precision => 7, :scale => 7
      t.integer :status
      t.integer :amount

      t.timestamps
    end
  end
end
