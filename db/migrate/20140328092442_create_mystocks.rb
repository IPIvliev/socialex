class CreateMystocks < ActiveRecord::Migration
  def change
    create_table :mystocks do |t|
      t.integer :user_id
      t.integer :host_id
      t.decimal :price,           :precision => 2, :scale => 2
      t.integer :amount

      t.timestamps
    end
  end
end
