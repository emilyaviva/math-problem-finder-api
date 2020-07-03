class Api::V1::TasksController < ApplicationController
  def index
    tasks = Task.all
    render json: { results: tasks }.to_json, status: :ok
  end
end
