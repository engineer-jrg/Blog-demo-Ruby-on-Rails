module ArticlesConcerns
    extend ActiveSupport::Concern
    
    def is_normal_user?
        self.permission_level >= 1
    end
end