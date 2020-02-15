class AddColumnStateToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :state, :string, default: "in_draft"
  end
end
