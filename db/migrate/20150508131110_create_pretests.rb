class CreatePretests < ActiveRecord::Migration
  def change

    create_table :pretests do |t|
      t.integer :member
      t.float :ko

      t.index :member, unique: true
    end

  end
end
