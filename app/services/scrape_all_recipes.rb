require "json"

class ScrapeAllRecipes
  include Service

  def initialize(ingredient)
    @ingredient = ingredient
  end

  def call
    recipes = parse_json("public/recipes-english.json")
    recipes_with_selected_ingredient = select_recipes_with_ingredient(recipes, @ingredient)
    initialize_recipes(recipes_with_selected_ingredient)
  end

  private

  def parse_json(filepath)
    serialized_recipes = File.read(filepath)
    JSON.parse(serialized_recipes)
  end

  def select_recipes_with_ingredient(recipes, ingredient)
    recipes.select { |recipe| recipe["ingredients"].find { |i| i.include?(ingredient) }}
  end

  def initialize_recipes(recipes)
    recipes.map do |recipe|
      title = recipe["title"]
      rating = recipe["ratings"]
      image = recipe["image"]
      total_time = recipe["cook_time"] + recipe["prep_time"]
      Recipe.new(title: title, rating: rating, image: image, total_time: total_time)
    end
  end
end
