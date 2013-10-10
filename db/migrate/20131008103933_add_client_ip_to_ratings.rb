class AddClientIpToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :client_ip, :string
  end
end
