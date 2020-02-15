class AddUserIdArticles < ActiveRecord::Migration[6.0]
  def change
    add_reference :articles, :user, foreign_key: true, index: true, default: 1
  end
end
