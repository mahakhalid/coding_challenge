# frozen_string_literal: true
class AuthorsController < ApplicationController
    before_action :set_author, only: [:show, :update, :destroy_with_transfer]
  
    def index
      @authors = Author.all
      render json: @authors
    end
  
    def show
      render json: @author
    end
  
    def new
      @author = Author.new
    end
  
    def edit
      @author = Author.find(params[:id])
    end
  
    def create
      author = Author.new(author_params)
  
      if author.save
        render json: author, status: :created, location: author
      else
        render json: author.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @author.update(author_params)
        render json: @author
      else
        render json: @author.errors, status: :unprocessable_entity
      end
    end

    def destroy_with_transfer
      # Assuming that new_author_id is provided in params when calling this so courses can be transferred to new author before destroying this author
      new_author_id = params[:new_author_id]
      # Check if the new author_id is present and if the author with that ID exists
      new_author = Author.find_by(id: new_author_id)
    
      if new_author
        transfer_courses(@author, new_author_id)
        @author.destroy
        render json: { message: 'Author deleted and courses transferred successfully.' }, status: :ok
      else
        render json: { error: 'Failed to delete author. The new author does not exist.' }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_author
      @author = Author.find(params[:id])
    end
  
    def author_params
      params.require(:author).permit(:name)
    end
  
    def transfer_courses(author, new_author_id)
        Author.transaction do
          courses = author.authored_courses
          courses.update_all(author_id: new_author_id)
        end
    end
end
  