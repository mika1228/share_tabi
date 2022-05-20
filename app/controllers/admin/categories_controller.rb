class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      @categories.all
      render :index
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @categories = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "You have updated category successfully."
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end