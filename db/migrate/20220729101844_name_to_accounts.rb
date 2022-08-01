class NameToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :full_name, :string
  end
end
