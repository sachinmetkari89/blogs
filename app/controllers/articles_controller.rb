class ArticlesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_article, only: [:show, :edit, :update, :destroy, :update_state]

  # GET /articles
  def index
    per_page = search_params[:per_page] || PER_PAGE
    user = current_user
    search = user.articles.search(search_params[:q])
    @articles = search.result(:distinct => true).page(search_params[:page]).per(per_page)
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/:id/edit
  def edit
    @article
  end

    # GET /articles/:id
  def show
    @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = t('controller.articles.new.success')
      redirect_to articles_path
    else
      flash[:errors] = @article.errors.messages
      redirect_to new_article_path
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      flash[:success] = t('controller.articles.update.success')
      redirect_to articles_path
    else
      flash[:errors] = @article.errors.full_messages
      redirect_to article_path(@article)
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    if @article.destroyed?
      flash[:success] = t('controller.articles.destroy.success')
      redirect_to articles_path
    else
      flash[:errors] = @article.errors.full_messages
      redirect_to articles_path
    end
  end

  def update_state
    new_state = update_article_state[:state]
    if @article.update!(state: new_state)
      render json: { data: @article, meta: { notice: t('controller.articles.update_state.success') } }, status: :ok
    else
      render json: { errors: @article.errors }, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = ::Article.find_by!(id: params[:id])
  end

  def search_params
    params.permit(:sort_by, :order, :page, q: [:title_cont, :category_id_eq, state_in: []])
  end

  def article_params
    params.require(:article).permit(:title, :description, :category_id)
  end

  def update_article_state
    params.require(:article).permit(:state)
  end
end
