class ChangeColumnTypesOfRatings < ActiveRecord::Migration
  def up
    change_column :ratings, :member, :integer
    change_column :ratings, :milestone, :integer
    change_column :ratings, :ko, :float
    change_column :ratings, :comment, :text
  end

  def down
    change_column :ratings, :member, :string
    change_column :ratings, :milestone, :string
    change_column :ratings, :ko, :string
    change_column :ratings, :comment, :string
  end
end
