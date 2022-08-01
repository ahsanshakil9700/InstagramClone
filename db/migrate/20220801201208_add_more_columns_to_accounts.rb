class AddMoreColumnsToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :website, :string
    add_column :accounts, :bio, :text
    add_column :accounts, :phone, :integer
    add_column :accounts, :gender, :string
  end
end
