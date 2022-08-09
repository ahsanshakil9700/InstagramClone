class Post < ApplicationRecord

  belongs_to :account

  has_many :photos, dependent: :destroy


  def belongs_to? account
    Post.find_by(account_id: account.id, id: id)
  end

end
