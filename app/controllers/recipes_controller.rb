class RecipesController < ActionController::Base
  def index
    @recipes = params[:query].present? ? ScrapeAllRecipes.call(params[:query]).first(10) : nil
  end
end
