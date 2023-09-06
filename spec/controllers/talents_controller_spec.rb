# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TalentsController, type: :controller do
  let(:valid_attributes) {
    { name: 'Test Talent' }
  }

  let(:invalid_attributes) {
    { name: '' } # Invalid attribute to test validations
  }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      talent = Talent.create! valid_attributes
      get :show, params: { id: talent.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new talent' do
        expect {
          post :create, params: { talent: valid_attributes }
        }.to change(Talent, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'does not create a new talent' do
        expect {
          post :create, params: { talent: invalid_attributes }
        }.to change(Talent, :count).by(0)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      talent = Talent.create! valid_attributes
      get :edit, params: { id: talent.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { name: 'Updated Talent Name' }
      }

      it 'updates the requested talent' do
        talent = Talent.create! valid_attributes
        put :update, params: { id: talent.to_param, talent: new_attributes }
        talent.reload
        expect(talent.name).to eq(new_attributes[:name])
      end
    end

    context 'with invalid params' do
      it 'does not update the requested talent' do
        talent = Talent.create! valid_attributes
        put :update, params: { id: talent.to_param, talent: invalid_attributes }
        talent.reload
        expect(talent.name).not_to eq('')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested talent' do
      talent = Talent.create! valid_attributes
      expect {
        delete :destroy, params: { id: talent.to_param }
      }.to change(Talent, :count).by(-1)
    end
  end
end