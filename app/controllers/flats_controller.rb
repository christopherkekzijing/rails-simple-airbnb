class FlatsController < ApplicationController

  before_action :set_flat, only: [:show, :edit, :destroy, :update]

  def index
    @search_result = params[:search]
    if @search_result.nil?
        @all_flats = Flat.all
        @flats = @all_flats.order("updated_at DESC")
      else
        @all_flats = Flat.where("name LIKE '%#{@search_result}%'")
        @flats = @all_flats.order("updated_at DESC")
    end
  end

  def show
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    if @flat.save
      redirect_to @flat, notice: 'You was created a flat listing.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @flat.update(flat_params)
    redirect_to @flat
    else
      render :new
    end
  end

  def destroy
    @flat.destroy
    redirect_to flats_path
  end

  # def search
  #   @flats = Flat.where("name LIKE '%#{params[:search]}%'")
  # end

private

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:name, :address, :description, :price_per_night, :number_of_guest)
  end
end
