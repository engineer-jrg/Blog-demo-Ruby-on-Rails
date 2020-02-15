class ChangeDefaultValueUserIdArticles < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:articles, :user_id, nil)
  end
end
