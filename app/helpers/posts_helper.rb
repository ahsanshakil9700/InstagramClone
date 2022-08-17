# frozen_string_literal: true

module PostsHelper
  def belongs_to?(account)
    Post.find_by(account_id: account.id, id: id)
  end

  def is_liked(account)
    Like.find_by(account_id: account.id, post_id: id)
  end
end
