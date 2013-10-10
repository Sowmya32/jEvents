class AddColumnToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :rating_total, :bigint
  end
end
