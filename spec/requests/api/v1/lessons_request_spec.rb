require 'rails_helper'

RSpec.describe "Api::V1::Lessons", type: :request do
  let!(:category) { create(:category) }
  let!(:lessons) { create_list(:lesson, 20, category_id: category.id) }
  let(:category_id) { category.id }
  let(:lesson_id) { lessons.first.id }

  describe 'GET /api/v1/lessons' do
    before { get "/api/v1/lessons" }

    context 'when lesson exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns all lessons in a particular category' do
        expect(json.size).to eq 20
        expect(json.first['category_id']).to eq category_id
      end
    end
  end

  describe 'GET /api/v1/lessons/:lesson_id' do
    before { get "/api/v1/lessons/#{lesson_id}" }

    context 'when lesson exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns the lesson' do
        expect(json['id']).to eq lesson_id
      end
    end

    context 'when lesson does not exist' do
      let(:lesson_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Lesson/)
      end
    end
  end

  describe 'POST /api/v1/lessons' do
    let(:valid_attributes) do
      { name: 'foo', summary: 'bar', category: category_id }
    end

    context 'when the request is valid' do
      before { post "/api/v1/lessons", params: valid_attributes }

      it 'creates a lesson in the appropriate category' do
        expect(json['name']).to eq 'foo'
        expect(json['summary']).to eq 'bar'
        expect(json['category_id']).to eq category_id
      end

      it 'returns status code 201' do
        expect(response).to have_http_status 201
      end
    end

    context 'when the request is invalid' do
      before { post "/api/v1/lessons", params: { name: 'foo', category: 0 } }

      it 'returns status code 422' do
        expect(response).to have_http_status 422
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end

  describe 'PUT /api/v1/lessons/:lesson_id' do
    let(:valid_attributes) do
      { name: 'baz', summary: 'quux', category: category_id }
    end

    context 'when the request is valid' do
      before { put "/api/v1/lessons/#{lesson_id}", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'updates the appropriate lesson' do
        expect(json['name']).to eq 'baz'
        expect(json['summary']).to eq 'quux'
        expect(json['category_id']).to eq category_id
      end
    end

    context 'when the request is invalid' do
      before { put "/api/v1/lessons/#{lesson_id}", params: { name: 'foo', category: 0 } }

      it 'returns status code 422' do
        expect(response).to have_http_status 422
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end

  describe 'DELETE /api/v1/lessons/:lesson_id' do
    before { delete "/api/v1/lessons/#{lesson_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status 204
    end
  end
end
