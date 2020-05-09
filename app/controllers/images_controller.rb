class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      flash[:success] = 'You have successfully saved an image.'
      redirect_to @image
    else
      render 'new'
    end
  end

  def index
    @images = Image.order(created_at: :desc)
  end

  def show
    @image = Image.find(params[:id])
  end

  private

  def image_params
    params.require(:image).permit(:title, :url)
  end
end
