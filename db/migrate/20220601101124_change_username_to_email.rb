class ChangeUsernameToEmail < ActiveRecord::Migration[5.2]
  def change
    rename_column :accounts, :username, :email
  end
end
