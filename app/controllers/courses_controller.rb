# frozen_string_literal: true
class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :update, :destroy]
  
  def index
    @courses = Course.all
    render json: @courses
  end
  
  def show
    render json: @course
  end

  def new
    @course = Course.new
  end

  def edit
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.new(course_params)

    # Check if learning_path_id is provided and set the learning path accordingly
    if params[:learning_path_id].present?
      @course.learning_path = LearningPath.find(params[:learning_path_id])
    end

    if @course.save
      render json: @course, status: :created, location: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def update
    if @course.update(course_params)
      render json: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
  end

  def mark_completed
    @course = Course.find_by(id: params[:id])
    @talent = Talent.find_by(id: params[:talent_id])
    if @course.present? && @talent.present?
      completed_course = CompletedCourse.create(course: @course, talent: @talent)
      if completed_course.save
        render json: { message: 'Course marked as completed' }
      else
        render json: { error: 'Failed to mark course as completed' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Course or talent is missing' }, status: :unprocessable_entity
    end
  end

  def complete_and_assign_next
    @course = Course.find(params[:id])
    @talent = Talent.find(params[:talent_id])
  
    # Mark the current course as completed for the talent
    completed_course = CompletedCourse.create(course: @course, talent: @talent)
  
    if completed_course.save
      # Find the next course in the learning path
      next_course = @course.learning_path.courses
                      .where('position > ?', @course.position)
                      .order(position: :asc)
                      .first
  
      if next_course.present?
        # Assign the talent to the next course
        next_course.talents = [@talent]
  
        # Ensure that the talent is assigned to the course
        if next_course.talents.include?(@talent)
          render json: { message: 'Course completed and talent assigned to the next course' }
        else
          render json: { error: 'Failed to assign talent to the next course' }, status: :unprocessable_entity
        end
      else
        render json: { message: 'Learning path is completed' }
      end
    else
      render json: { error: 'Failed to mark course as completed' }, status: :unprocessable_entity
    end
  end
  

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :author_id, :learning_path_id)
  end
end
  