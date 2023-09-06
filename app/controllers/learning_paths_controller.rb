# frozen_string_literal: true
class LearningPathsController < ApplicationController
  before_action :set_learning_path, only: [:show, :update, :destroy]

  def index
    @learning_paths = LearningPath.all
    render json: @learning_paths
  end

  def show
    render json: @learning_path
  end

  def create
    @learning_path = LearningPath.new(learning_path_params)

    if @learning_path.save
    render json: @learning_path, status: :created, location: @learning_path
    else
    render json: @learning_path.errors, status: :unprocessable_entity
    end
  end

  def update
    if @learning_path.update(learning_path_params)
    render json: @learning_path
    else
    render json: @learning_path.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @learning_path.destroy
  end

  private

  def set_learning_path
    @learning_path = LearningPath.find(params[:id])
  end

  def learning_path_params
    params.require(:learning_path).permit(:name)
  end
end
  
