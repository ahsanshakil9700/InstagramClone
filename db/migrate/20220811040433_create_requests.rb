# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer 'user_id'
      t.integer 'following_id'
      t.boolean 'is_accepted'
      t.timestamps
    end
  end
end
