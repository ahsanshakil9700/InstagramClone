# frozen_string_literal: true

class AddMoreColumnsToAccounts < ActiveRecord::Migration[5.2]
  def change
    change_table :accounts, bulk: true do |t|
      t.string :website
      t.text :bio
      t.integer :phone
      t.string :gender
    end
  end
end
