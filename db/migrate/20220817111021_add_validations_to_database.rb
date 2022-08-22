# frozen_string_literal: true

class AddValidationsToDatabase < ActiveRecord::Migration[5.2]
  def change
    change_column_null :comments, :content, false
    change_column_null :comments, :post_id, false
    change_column_null :comments, :account_id, false

    change_column_null :follows, :account_id, false
    change_column_null :follows, :following_id, false

    change_column_null :likes, :post_id, false
    change_column_null :likes, :account_id, false
    change_column_null :photos, :image, false

    change_column_null :posts, :account_id, false

    change_column_null :requests, :account_id, false
    change_column_null :requests, :following_id, false

    change_column_null :stories, :account_id, false
  end
end
