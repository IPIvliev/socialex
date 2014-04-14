class CreateMystocks < ActiveRecord::Migration
  def change
    create_table :mystocks do |t|
      t.integer :user_id
      t.integer :host_id
      t.decimal :price,           :precision => 7, :scale => 7
      t.integer :amount

      t.timestamps
    end
  end
end
