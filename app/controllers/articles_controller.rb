class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    articles = Article.all.includes(:user).order(created_at: :desc)
    render json: articles, each_serializer: ArticleListSerializer
  end

  def show
    page_views = sessions[:page_views]
    if page_views > 4
      article = Article.find(params[:id])
      render json: article
    else render json: {erorr: "You've already read 3 articles"}, status: 401
  end
  end

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end


end
