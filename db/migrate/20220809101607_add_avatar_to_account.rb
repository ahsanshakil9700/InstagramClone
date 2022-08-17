# frozen_string_literal: true

class AddAvatarToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :avatar, :string
  end
end
