class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "123", password: "123", except: [:index, :show]

  def index
    set_meta_tags title: 'Listing Articles'
    set_meta_tags description: 'All articles'
    set_meta_tags keywords: 'Article, All'
    @articles = Article.all
    if request.headers['X-PJAX']
      render :layout => 'pjax'
    end
  end

  def show
    @article = Article.find(params[:id])
    set_meta_tags title: @article.title
    set_meta_tags description: @article.text
    set_meta_tags keywords: 'Article, Comments'
    if request.headers['X-PJAX']
      render :layout => 'pjax'
    end
  end

  def new
    set_meta_tags title:'New Article'
    set_meta_tags description: 'Create new article'
    set_meta_tags keywords: 'Article, New'
    @article = Article.new
    if request.headers['X-PJAX']
      render :layout => 'pjax'
    end
  end

  def edit
    set_meta_tags title:'Edit Article'
    set_meta_tags description: 'Edit article'
    set_meta_tags keywords: 'Article, Edit'
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
