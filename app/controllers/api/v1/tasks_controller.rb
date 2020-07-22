module Api
  module V1
    # API for routes under /api/v1/tasks
    class TasksController < ApplicationController
      before_action :set_task, only: %i[show update destroy]

      # GET /api/v1/tasks
      def index
        @tasks = Task.all
        json_response(@tasks)
      end

      # GET /api/v1/tasks/:id
      def show
        json_response(@task)
      end

      # POST /api/v1/tasks
      def create
        @task = Task.create!(task_params)
        json_response(@task, :created)
      end

      # PUT/PATCH /api/v1/tasks/:id
      def update
        @task.update!(task_params)
        json_response(@task)
      end

      # DELETE /api/v1/tasks/:id
      def destroy
        @task.destroy
        head :no_content
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
          tp = params.permit(:name, :source, :link, :commentary, lessons: [])
          lessons = params[:lessons]
          raise Api::V1::UnprocessableMappingError if lessons.nil?
          tp[:lessons] = lessons&.map do |l|
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
  end
end
