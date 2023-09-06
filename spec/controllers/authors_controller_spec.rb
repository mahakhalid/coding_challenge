# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  let(:valid_attributes) {
    { name: 'Test Author' }
  }

  let(:invalid_attributes) {
    { name: '' } # Invalid attribute to test validations
  }

  describe 'GET #index' do
    it 'returns a success response' do
      author = Author.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      author = Author.create! valid_attributes
      get :show, params: { id: author.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      author = Author.create! valid_attributes
      get :edit, params: { id: author.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new author' do
        expect {
          post :create, params: { author: valid_attributes }
        }.to change(Author, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'does not create a new author' do
        expect {
          post :create, params: { author: invalid_attributes }
        }.to change(Author, :count).by(0)
      end
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) {
      { name: 'Updated Author Name' }
    }

    context 'with valid params' do
      it 'updates the requested author' do
        author = Author.create! valid_attributes
        put :update, params: { id: author.to_param, author: new_attributes }
        author.reload
        expect(author.name).to eq(new_attributes[:name])
      end
    end

    context 'with invalid params' do
      it 'does not update the requested author' do
        author = Author.create! valid_attributes
        put :update, params: { id: author.to_param, author: invalid_attributes }
        author.reload
        expect(author.name).not_to eq('')
      end
    end
  end

  describe 'DELETE #destroy_with_transfer' do
    it 'transfers the author\'s courses to another author' do
      author = Author.create!(valid_attributes)
      new_author = Author.create!(valid_attributes) # Create a new author
      course = Course.create!(title: 'Test Course', author_id: author.id) # Create a course associated with the author

      expect {
        delete :destroy_with_transfer, params: { id: author.to_param, new_author_id: new_author.id }
      }.to change { Course.where(author_id: author.id).count }.from(1).to(0) # Expect the course to be transferred to the new author
    end

    it 'returns an error if no new author ID is provided' do
      author = Author.create! valid_attributes
      expect {
        delete :destroy_with_transfer, params: { id: author.to_param }
      }.to_not change(Author, :count)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
