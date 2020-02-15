class Article < ApplicationRecord
    include AASM

    belongs_to :user
    has_many :comments
    has_one_attached :cover
    has_many :has_categories
    has_many :categories, :through => :has_categories

    validates :title, presence: true, uniqueness: true
    validates :body, presence: true, length: { minimum: 20 }
    validates :cover, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
        dimension: { 
            width: { min: 500, max: 2400 },
            height: { min: 200, max: 1800 }, message: 'is not given between dimension' 
        }

    before_create :set_visits_count
    after_create :save_categories
    after_create :send_mail

    aasm column: :state do
        state :in_draft, initial: true
        state :published

        event :publish do
            transitions from: :in_draft, to: :published
        end

        event :unpublish do
            transitions from: :published, to: :in_draft
        end
    end

    scope :publicados, -> { where(state: "published") }
    scope :en_borrador, -> { where(state: "in_draft") }
    scope :ultimos, -> { order("created_at DESC") }
    scope :ultimos_limit_10, -> { order("created_at DESC").limit(10) }
=begin
    def self.publicados
        Article.where(state: "published")
    end
=end
    def send_mail
        ArticleMailer.new_article(self).deliver_later
    end

    def categories=(value)
        @categories = value
    end

    def save_categories
        @categories.each do |category_id|
            HasCategory.create(category_id: category_id, article_id: self.id)
        end
    end

    def thumbnail
        return self.cover.variant(resize: 600)
    end

    def update_visits_count
        self.update(visits_count: (if self.visits_count.nil? then 1 else (self.visits_count + 1) end))
    end

    private
        def set_visits_count
            self.visits_count = 0
        end
end
