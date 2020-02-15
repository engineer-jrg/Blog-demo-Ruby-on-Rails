
class HomeController < ApplicationController
before_action :authenticate_admin!, only: [:dashboard]

  def index
  end

  def dashboard
    @articles = Article.paginate(page: params[:page], per_page: 6).ultimos
  end
end