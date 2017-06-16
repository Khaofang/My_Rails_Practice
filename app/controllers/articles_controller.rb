class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "123", password: "123", except: [:index, :show]

  def index
    @articles = Article.all
    if request.headers['X-PJAX']
      render :layout => false
    end
  end

  def show
    @article = Article.find(params[:id])
    if request.headers['X-PJAX']
      render :layout => false
    end
  end

  def new
    @article = Article.new
    if request.headers['X-PJAX']
      render :layout => false
    end
  end

  def edit
    @article = Article.find(params[:id])
    if request.headers['X-PJAX']
      render :layout => false
    end
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      logger.info "Success"
      redirect_to @article
    else
      logger.info "Failed to create new article"
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
