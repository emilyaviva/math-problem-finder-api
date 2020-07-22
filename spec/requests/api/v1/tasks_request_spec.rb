require 'rails_helper'

RSpec.describe "Api::V1::Tasks", type: :request do
  let!(:categories) { create_list(:category, 2) }
  let!(:lessons_in_category1) do
    create_list(:lesson, 2, category: categories.first)
  end
  let!(:lessons_in_category2) do
    create_list(:lesson, 2, category: categories.second)
  end
  let!(:task1) { create(:task, lessons: lessons_in_category1) }
  let!(:task2) { create(:task, lessons: lessons_in_category2) }
  let(:task_id) { task1.id }

  describe 'GET /api/v1/tasks' do
    before { get "/api/v1/tasks" }

    context 'when task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns all tasks' do
        expect(json.size).to eq 2
      end
    end
  end

  describe 'GET /api/v1/tasks/:task_id' do
    before { get "/api/v1/tasks/#{task_id}" }

    context 'when task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns the task' do
        expect(json['id']).to eq task_id
      end
    end

    context 'when task does not exist' do
      let(:task_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  describe 'POST /api/v1/tasks' do
    let(:valid_attributes) do
      {
        name: 'foo',
        source: 'bar',
        link: 'baz',
        commentary: 'quux',
        lessons: [lessons_in_category1.first.id, lessons_in_category2.first.id]
      }
    end

    context 'when the request is valid' do
      before { post "/api/v1/tasks", params: valid_attributes }

      it 'creates a task with the appropriate lessons and categories' do
        expect(json['name']).to eq 'foo'
        expect(json['lessons_ids']).to contain_exactly(lessons_in_category1.first.id, lessons_in_category2.first.id)
        expect(json['categories_ids']).to contain_exactly(categories.first.id, categories.second.id)
      end
    end

    context 'when the request is invalid' do
      before { post "/api/v1/tasks", params: { name: 'foo' } }

      it 'returns status code 422' do
        expect(response).to have_http_status 422
      end

      it 'returns an unprocessable mapping message' do
        expect(response.body).to match(/Unprocessable mapping/)
      end
    end
  end

  describe 'PUT /api/v1/tasks/:task_id' do
    let(:valid_attributes) do
      {
        name: 'geez',
        source: 'wheez',
        link: 'poiuyt',
        commentary: 'noll',
        lessons: [lessons_in_category1.second.id]
      }
    end

    context 'when the request is valid' do
      before { put "/api/v1/tasks/#{task_id}", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'updates the appropriate lesson' do
        expect(json['name']).to eq 'geez'
        expect(json['source']).to eq 'wheez'
        expect(json['link']).to eq 'poiuyt'
        expect(json['commentary']).to eq 'noll'
        expect(json['categories_ids']).to contain_exactly(categories.first.id)
      end
    end

    context 'when the request is invalid' do
      before { put "/api/v1/tasks/#{task_id}", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status 422
      end

      it 'returns an unprocessable mapping message' do
        expect(response.body).to match(/Unprocessable mapping/)
      end
    end
  end

  describe 'DELETE /api/v1/tasks/:task_id' do
    before { delete "/api/v1/tasks/#{task_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status 204
    end
  end
end
