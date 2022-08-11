class ChangeDefaultValueOfName < ActiveRecord::Migration[5.2]
  def change
    change_column_default :accounts, :full_name, ''
  end
end
