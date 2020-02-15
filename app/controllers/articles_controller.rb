class ArticlesController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]
    before_action :set_article, except: [:new, :index, :create]
    before_action :authenticate_editor!, only: [:new, :create, :update, :edit]
    before_action :authenticate_admin!, only: [:destroy, :publish]

    # GET /articles
    def index
        @articles = Article.paginate(page: params[:page], per_page: 6).publicados.ultimos
    end
    # GET /articles/:id
    def show
        unless @article.may_unpublish?
            flash[:notice] = 'Article with unpublished status'
            return redirect_to articles_path
        end
        @article.update_visits_count
        @comment = Comment.new
    end
    # GET /articles/new
    def new
        @article = Article.new
    end
    # POST /articles
    def create
        @article = current_user.articles.new(article_params)
        @article.categories = params[:categories]
        if @article.valid?
            @article.save
            redirect_to @article
        else
            render :new
        end
    end
    # DELETE /articles/:id
    def destroy
        @article.destroy
        redirect_to articles_path
    end
    # GET /articles/:id/edit
    def edit
        unless !@article.user.id.equal? params[:id] && !current_user.is_admin?
            flash[:notice] = 'The article can only be edited by the user who created it'
            return redirect_to @article
        end
    end
    # PUT /articles/:id
    def update
        if @article.update(article_params)
            redirect_to @article
        else
            render :edit
        end
    end

    # PUT /articles/:id/publish
    def publish
        if @article.may_publish?
            @article.publish!
        end
        redirect_to dashboard_path
    end

    # PUT /articles/:id/unpublish
    def unpublish
        if @article.may_unpublish?
            @article.unpublish!
        end
        redirect_to dashboard_path
    end

    private

    def article_params
        params.require(:article).permit(:title, :body, :cover, :categories) #, comment_attributes: [ :user_id, :article_id, :body ]
    end

    def validate_user
        redirect_to new_user_session_path, notice: "To create an article you need to login"
    end

    def set_article
        @article = Article.find(params[:id])
    end
end