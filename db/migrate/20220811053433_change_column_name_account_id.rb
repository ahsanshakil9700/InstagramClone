class ChangeColumnNameAccountId < ActiveRecord::Migration[5.2]
  def change
    rename_column :follows, :user_id, :account_id
    rename_column :requests, :user_id, :account_id
  end
end
