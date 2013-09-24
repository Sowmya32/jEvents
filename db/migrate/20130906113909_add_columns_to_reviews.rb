class AddColumnsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :rating_venue, :integer
    add_column :reviews, :rating_food, :integer
    add_column :reviews, :rating_services, :integer
    add_column :reviews, :rating_facilities, :integer
  end
end
