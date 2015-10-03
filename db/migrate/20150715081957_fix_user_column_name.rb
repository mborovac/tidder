class FixUserColumnName < ActiveRecord::Migration
  def self.up
    rename_column :users, :ancrypted_password, :encrypted_password
  end
end
