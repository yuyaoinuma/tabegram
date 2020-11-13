class AddImageProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image_profile, :string
  end
end
