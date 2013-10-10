class AddFieldsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :rating_total, :int
    add_column :reviews, :rating_count, :int
  end
end
