class Api::V1::TasksController < ApplicationController
  before_action :set_task, only: %i[show update destroy]

  # GET /api/v1/tasks
  def index
    @tasks = Task.all
    render json: @tasks, status: :ok
  end

  # GET /api/v1/tasks/:id
  def show
    render json: @task, status: :ok
  end

  # POST /api/v1/tasks
  def create
    @task = Task.new(task_params)
    if @task.save
      render json: @task, status: :created, location: api_v1_task_url(@task)
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /api/v1/tasks/:id
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tasks/:id
  def destroy
    @task.destroy
    render json: {}, status: :no_content
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  # We expect an array for the :lessons param
  # If contents are numbers, we look up lesson by ID
  # Otherwise, try to look up the right lesson by name
  def task_params
    @task_params ||= begin
      tp = params
        .require(:task)
        .permit(:name, :source, :link, :commentary, lessons: [])
      lessons = params.require(:lessons)
      tp[:lessons] = lessons.map do |l|
        if l.to_i.positive?
          Lesson.find(l)
        else
          Lesson.find_by(name: l)
        end
      end
      tp
    end
  end
end
