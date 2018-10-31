require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all

    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @new_recipes = Recipe.create(name: params["name"], ingredients: params["ingredients"], cook_time: params["cook_time"])

    redirect "/recipes/#{@new_recipes.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params["id"])

    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe_to_edit = Recipe.find(params["id"])

    erb :edit
  end

  patch '/recipes/:id' do
    @new_name = params["name"]
    @new_ingredients = params["ingredients"]
    @new_cook_time = params["cook_time"]

    @old_recipe = Recipe.find(params["id"])

    if @new_name != ""
      @old_recipe.update_attribute(:name, @new_name)
    end
    if @new_ingredients != ""
      @old_recipe.update_attribute(:ingredients, @new_ingredients)
    end
    if @new_cook_time != ""
      @old_recipe.update_attribute(:cook_time, @new_cook_time)
    end

    redirect "/recipes/#{@old_recipe.id}"
  end

  delete '/recipes/:id/delete' do
    @all_recipes = Recipe.all

    @all_recipes.destroy(params["id"])

    redirect '/recipes'
  end

end
