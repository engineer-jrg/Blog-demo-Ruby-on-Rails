class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception

    before_action :set_categories

    def authenticate_editor!
        unless user_signed_in? && current_user.permission_level >= 2
            flash[:notice] = 'You need editor permissions for this action'
            return redirect_to root_path
        end 
    end

    def authenticate_admin!
        unless user_signed_in? && current_user.permission_level >= 3
            flash[:notice] = 'You need admin permissions for this action'
            return redirect_to root_path 
        end
    end

    def set_categories
        @categories = Category.all
    end
        
end
