class AddApiIdToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :api_id, :string
  end
end
