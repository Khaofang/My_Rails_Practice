class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "123", password: "123", except: [:index, :show]

  def index
    @title = 'Listing Articles'
    @description = 'All articles'
    @articles = Article.all
    if request.headers['X-PJAX']
      render :layout => 'pjax'
    end
  end

  def show
    @article = Article.find(params[:id])
    @title = @article.title
    @description = @article.text
    if request.headers['X-PJAX']
      render :layout => 'pjax'
    end
  end

  def new
    @title = 'New Article'
    @description = 'Create new article'
    @article = Article.new
    if request.headers['X-PJAX']
      render :layout => 'pjax'
    end
  end

  def edit
    @title = 'Edit Article'
    @description = 'Edit article: ' + @article.title
    @article = Article.find(params[:id])
    if request.headers['X-PJAX']
      render :layout => 'pjax'
    end
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
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
