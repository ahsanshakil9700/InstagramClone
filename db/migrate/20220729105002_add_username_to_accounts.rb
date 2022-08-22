# frozen_string_literal: true

class AddUsernameToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :username, :string
  end
end
