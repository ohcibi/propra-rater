class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :member
      t.string :milestone
      t.string :ko

      t.index [:member, :milestone], unique: true
      t.index :member
    end
  end
end
