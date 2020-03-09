class HomeController < ApplicationController
  def index
    per_page = search_params[:per_page] || PER_PAGE
    search = Article.published.ransack(search_params[:q])
    @articles = search.result(:distinct => true).page(search_params[:page]).per(per_page)
  end

  private

  def search_params
    params.permit(:sort_by, :order, :page, :per_page, q: [:title_cont, :category_id_eq, state_in: []])
  end

  def article_params
    params.require(:article).permit(:title, :description, :category_id, :state)
  end
end
