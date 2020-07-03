class Api::V1::CategoriesController < ApplicationController
  def index
    categories = Category.all
    render json: { results: categories }.to_json, status: :ok
  end
end
