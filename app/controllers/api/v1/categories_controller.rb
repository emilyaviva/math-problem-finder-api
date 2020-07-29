module Api
  module V1
    # API for routes under /api/v1/categories
    class CategoriesController < ApplicationController
      before_action :set_category, only: %i[show update destroy]

      # GET /api/v1/categories
      def index
        @categories = Category.all
        json_response(@categories)
      end

      # GET /api/v1/categories/:id
      def show
        json_response(@category)
      end

      # POST /api/v1/categories
      def create
        @category = Category.create!(category_params)
        json_response(@category, :created)
      end

      # PUT/PATCH /api/v1/categories/:id
      def update
        @category.update!(category_params)
        json_response(@category)
      end

      # DELETE /api/v1/categories/:id
      def destroy
        @category.destroy
        head :no_content
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.permit(:name)
      end
    end
  end
end
