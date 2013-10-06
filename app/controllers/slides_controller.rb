class SlidesController < ApplicationController
  before_filter :setup_slideshow

  def index
    @slides = @slideshow.slides.order('slide_number')
  end

  def edit
    @slide = @slideshow.slides.find(params[:id])
  end

  def update
    @slide = @slideshow.slides.find(params[:id])
    if @slide.update_attributes(params[:slide])
      redirect_to slideshow_slides_path(@slideshow), notice: 'Updated slide successfully.'
    else
      render :edit
    end
  end

private

  def setup_slideshow
    @slideshow = Slideshow.find(params[:slideshow_id])
  end
end
