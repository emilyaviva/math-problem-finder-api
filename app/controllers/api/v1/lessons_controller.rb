class Api::V1::LessonsController < ApplicationController
  def index
    lessons = Lesson.all
    render json: { results: lessons }.to_json, status: :ok
  end
end
