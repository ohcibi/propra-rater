class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :ident
      t.string :token
      t.datetime :token_expires_at

      t.index :ident
      t.index :token, unique: true
    end
  end
end
