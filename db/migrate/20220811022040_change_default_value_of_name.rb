# frozen_string_literal: true

class ChangeDefaultValueOfName < ActiveRecord::Migration[5.2]
  def change
    change_column_default :accounts, :full_name, from: nil, to: ''
  end
end
