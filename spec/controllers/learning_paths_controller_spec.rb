# frozen_string_literal: true
require 'rails_helper'

RSpec.describe LearningPathsController, type: :controller do
  describe 'GET #index' do
    it 'returns a JSON response with a list of learning paths' do
      learning_paths = FactoryBot.create_list(:learning_path, 3)

      get :index

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to match_array(learning_paths.as_json)
    end
  end

  describe 'GET #show' do
    it 'returns a JSON response with the specified learning path' do
      learning_path = FactoryBot.create(:learning_path)

      get :show, params: { id: learning_path.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(learning_path.as_json)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new learning path' do
        learning_path_params = FactoryBot.attributes_for(:learning_path)

        expect {
          post :create, params: { learning_path: learning_path_params }
        }.to change(LearningPath, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('id', 'name')
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status' do
        learning_path_params = { name: nil }

        post :create, params: { learning_path: learning_path_params }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('name')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      it 'updates the specified learning path' do
        learning_path = FactoryBot.create(:learning_path)
        updated_name = 'Updated Learning Path Name'

        put :update, params: { id: learning_path.id, learning_path: { name: updated_name } }
        learning_path.reload

        expect(response).to have_http_status(:ok)
        expect(learning_path.name).to eq(updated_name)
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status' do
        learning_path = FactoryBot.create(:learning_path)

        put :update, params: { id: learning_path.id, learning_path: { name: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('name')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the specified learning path' do
      learning_path = FactoryBot.create(:learning_path)

      expect {
        delete :destroy, params: { id: learning_path.id }
      }.to change(LearningPath, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
