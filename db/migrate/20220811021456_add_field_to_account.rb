# frozen_string_literal: true

class AddFieldToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :private, :boolean, default: false
  end
end
