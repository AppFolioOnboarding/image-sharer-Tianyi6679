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
    if params[:tag_filter].blank?
      @images = Image.order(created_at: :desc)
      @filter_msg = 'No tag is selected'
    else
      @images = Image.tagged_with(params[:tag_filter]).order(created_at: :desc)
      @filter_msg = 'Tag ' + params[:tag_filter] + ' is selected'
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  private

  def image_params
    params.require(:image).permit(:title, :url, :tag_list)
  end
end
