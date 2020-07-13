class Api::V1::LessonsController < ApplicationController
  before_action :set_lesson, only: %i[show update destroy]

  # GET /api/v1/lessons
  def index
    @lessons = Lesson.all
    json_response(@lessons)
  end

  # GET /api/v1/lessons/:id
  def show
    json_response(@lesson)
  end

  # POST /api/v1/lessons
  def create
    @lesson = Lesson.create!(lesson_params)
    json_response(@lesson, :created)
  end

  # PUT/PATCH /api/v1/lessons/:id
  def update
    @lesson.update!(lesson_params)
    json_response(@lesson)
  end

  # DELETE /api/v1/lessons/:id
  def destroy
    @lesson.destroy
    head :no_content
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  # If user supplies a number as the category, treat it as the category id
  # Otherwise, try to look up the right category by name
  def lesson_params
    @lesson_params ||= begin
      lp = params.permit(:name, :summary, :category, :source)
      category = params.require(:category)
      lp[:category] = if category.to_i.positive?
        Category.find(category)
      else
        Category.find_by(name: category)
      end
      lp
    end
  end
end
