class AddLockVersionToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :lock_version, :integer, :default => 0
  end
end
