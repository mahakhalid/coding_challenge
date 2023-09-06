# frozen_string_literal: true
class TalentsController < ApplicationController
  before_action :set_talent, only: [:show, :update, :destroy]

  def index
    @talents = Talent.all
    render json: @talents
  end

  def new
    @talent = Talent.new
  end

  def edit
    @talent = Talent.find(params[:id])
  end

  def show
    render json: @talent
  end

  def create
    @talent = Talent.new(talent_params)

    if @talent.save
      render json: @talent, status: :created, location: @talent
    else
      render json: @talent.errors, status: :unprocessable_entity
    end
  end

  def update
    if @talent.update(talent_params)
      render json: @talent
    else
      render json: @talent.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @talent.destroy
  end

  private

  def set_talent
    @talent = Talent.find(params[:id])
  end

  def talent_params
    params.require(:talent).permit(:name)
  end
end
