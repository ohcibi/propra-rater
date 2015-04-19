class AddCommentToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :comment, :string
  end
end
