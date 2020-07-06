class Api::V1::LessonsController < ApplicationController
  before_action :set_lesson, only: %i[show update destroy]

  # GET /api/v1/lessons
  def index
    @lessons = Lesson.all
    render json: @lessons, status: :ok
  end

  # GET /api/v1/lessons/:id
  def show
    render json: @lesson, status: :ok
  end

  # POST /api/v1/lessons
  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      render json: @lesson, status: :created, location: api_v1_lesson_url(@lesson)
    else
      render json: @lesson.errors, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /api/v1/lessons/:id
  def update
    if @lesson.update(lesson_params)
      render json: @lesson
    else
      render json: @lesson.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/lessons/:id
  def destroy
    @lesson.destroy
    render json: {}, status: :no_content
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  # If user supplies a number as the category, treat it as the category id
  # Otherwise, try to look up the right category by name
  def lesson_params
    params.require(:lesson).permit(:name, :summary, :category, :source)
    params[:category] = if params[:category].to_i.positive?
      Category.find(params[:category])
    else
      Category.find_by(name: params[:category])
    end
    params
  end
end
