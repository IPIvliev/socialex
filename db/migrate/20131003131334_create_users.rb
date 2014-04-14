class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :username
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.decimal  :pocket,                 :precision => 9, :scale => 2, :default => 0.0

      t.timestamps
    end
  end
end
