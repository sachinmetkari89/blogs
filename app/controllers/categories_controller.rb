class CategoriesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  def index
    per_page = search_params[:per_page] || PER_PAGE
    search = Category.search(search_params[:q])
    @categories = search.result(:distinct => true).page(search_params[:page]).per(per_page)
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/:id
  def show
    @category
  end

  # GET /categories/:id/edit
  def edit
    @category
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t('controller.categories.new.success')
      redirect_to categories_path
    else
      flash[:errors] = @category.errors.full_messages
      redirect_to new_category_path
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      flash[:success] = t('controller.categories.update.success')
      redirect_to categories_path
    else
      flash[:errors] = @category.errors.full_messages
      redirect_to category_path(@category)
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    if @category.destroyed?
      flash[:success] = t('controller.categories.destroy.success')
      redirect_to categories_path
    else
      flash[:errors] = @category.errors.full_messages
      redirect_to categories_path
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = ::Category.find_by!(id: params[:id])
  end

  def search_params
    params.permit(:sort_by, :order, :page, :per_page, q: [:name_cont])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
