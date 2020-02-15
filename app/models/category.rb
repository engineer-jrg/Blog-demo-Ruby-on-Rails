class Category < ApplicationRecord
    validates :name, presence: true
    has_many :has_categories
    has_many :articles, :through => :has_categories

    # scope :articles_published, -> { joins(:has_categories) }
    # Category.find(1).articles.where(state: "in_draft")
end
