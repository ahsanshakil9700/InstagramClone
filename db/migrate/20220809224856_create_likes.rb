# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :post, foreign_key: true
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
