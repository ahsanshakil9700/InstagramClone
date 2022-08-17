# frozen_string_literal: true

class EditPostModel < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :account, index: true
  end
end
