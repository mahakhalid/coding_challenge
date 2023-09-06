# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let(:valid_author_attributes) { { name: 'Test Author' } }
  let(:valid_course_attributes) { { title: 'Test Course' } } # Change valid_attributes to valid_course_attributes
  let(:invalid_attributes) { { title: '' } }
  
    describe 'GET #index' do
      it 'returns a success response' do
        author = Author.create!(valid_author_attributes)
        valid_course_attributes[:author_id] = author.id
  
        get :index
        expect(response).to be_successful
      end
    end
  
    describe 'GET #show' do
      it 'returns a success response' do
        author = Author.create!(valid_author_attributes)
        valid_course_attributes[:author_id] = author.id
  
        course = Course.create!(valid_course_attributes)
        get :show, params: { id: course.to_param }
        expect(response).to be_successful
      end
    end

    describe 'POST #create' do
      context 'with valid parameters' do
        let(:valid_course_params) do
          {
            course: {
              title: 'Test Course',
              author_id: create(:author).id,
              learning_path_id: create(:learning_path).id
            }
          }
        end
  
        it 'creates a new course' do
          expect do
            post :create, params: valid_course_params
          end.to change(Course, :count).by(1)
  
          expect(response).to have_http_status(:created)
          expect(JSON.parse(response.body)['title']).to eq(valid_course_params[:course][:title])
        end
      end
  
      context 'with invalid parameters' do
        let(:invalid_course_params) do
          {
            course: {
              title: '',  # Invalid title
              author_id: create(:author).id,
              learning_path_id: create(:learning_path).id
            }
          }
        end
  
        it 'returns unprocessable entity status' do
          post :create, params: invalid_course_params
  
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  
    describe 'POST #mark_completed' do
      it 'marks the course as completed for the talent' do
        author = Author.create!(valid_author_attributes)
        valid_course_attributes[:author_id] = author.id
  
        course = Course.create!(valid_course_attributes) # Change valid_attributes to valid_course_attributes
        talent = Talent.create!(name: 'Test Talent')
  
        post :mark_completed, params: { id: course.to_param, talent_id: talent.id }
        expect(response).to have_http_status(:success)
      end

      it 'returns an error if the course is missing' do
        talent = FactoryBot.create(:talent)
        post :mark_completed, params: { id: -1, talent_id: talent.id }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error if the talent is missing' do
        author = Author.create!(valid_author_attributes) # Create an author
        valid_course_attributes[:author_id] = author.id # Associate the author with the course
        course = Course.create!(valid_course_attributes)
        post :mark_completed, params: { id: course.id, talent_id: -1 }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  
    describe 'POST #complete_and_assign_next' do
      
      it 'marks the course as completed for the talent and assigns the next course' do
        author = Author.create!(valid_author_attributes)
        talent = Talent.create!(name: 'Test Talent')
        course1 = Course.create!(title: 'Course 1', author: author)
        course1 = Course.create!(title: 'Course 1', author: author)
        # Manually create an association record in the join table
        course1.talents << talent
        
        learning_path = LearningPath.create!(name: 'Learning Path 1')
  
        # Associate course2 with the learning path
        learning_path.courses << course1
        course1.learning_path = learning_path
        course1.save
  
        post :complete_and_assign_next, params: { id: course1.to_param, talent_id: talent.id }
        expect(course1.talents).to include(talent)
        expect(response).to have_http_status(:success)
      end

      it 'marks the course as completed for the talent and assigns the next course' do

        author = Author.create!(valid_author_attributes)
        talent = Talent.create!(name: 'Test Talent')
        # Create a course
        course1 = Course.create!(title: 'Course 1', author: author)
        # Manually create an association record in the join table
        course1.talents << talent
        
  
        # Create a learning path with a name
        learning_path = LearningPath.create!(name: 'Learning Path 1')
  
        # Associate course2 with the learning path
        learning_path.courses << course1
        course1.learning_path = learning_path
        course1.save
      
        post :complete_and_assign_next, params: { id: course1.to_param, talent_id: talent.id }
        expect(course1.talents).to include(talent)
        expect(response).to have_http_status(:success)
      end
      
  
      it 'returns a message when the learning path is completed' do
        author = Author.create!(valid_author_attributes)
        course1 = Course.create!(title: 'Course 1', author: author)
        course1 = Course.create!(title: 'Course 1', author: author)
        talent = Talent.create!(name: 'Test Talent')
        course1.talents << talent
  
        # Create a learning path and associate course1 with it
        learning_path = LearningPath.create!(name: 'Learning Path 1')
        learning_path.courses << course1
        course1.learning_path = learning_path
        course1.save
  
        post :complete_and_assign_next, params: { id: course1.to_param, talent_id: talent.id }
        expect(response).to have_http_status(:success)
        expect(response.body).to include('Learning path is completed')
      end

      context 'when the talent is missing' do
        it 'returns an error with a :unprocessable_entity status' do
          author = Author.create!(name: 'Test Author')
          course = Course.create!(title: 'Course 1', author: author)
      
          # Stub the Talent.find method to return nil
          allow(Talent).to receive(:find).and_return(nil)
      
          post :complete_and_assign_next, params: { id: course.id, talent_id: 999 }  # Talent ID does not exist
      
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)).to eq({ 'error' => 'Failed to mark course as completed' })
        end
      end

      context 'when the course is missing' do
        it 'returns an error with a :unprocessable_entity status' do
          talent = Talent.create!(name: 'Test Talent')

          allow(Course).to receive(:find).and_return(nil)
      
          post :complete_and_assign_next, params: { id: 999, talent_id: talent.id }  # Course ID does not exist

          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)).to eq({ 'error' => 'Failed to mark course as completed' })
        end
      end

    end
end
