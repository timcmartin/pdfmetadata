class ChartsController < ApplicationController
  def create
    @chart = Chart.new(chart_params)
    if @chart.valid? && @chart.process_pdf
      flash[:success] = "#{@chart.title} has been updated."
      redirect_to '/'
    else
      flash.now[:error] = "#{@chart.errors.full_messages}"
      render :action => 'index'
    end
  end

  private

  def chart_params
    params.require(:chart).permit(:title, :path, :composer, :genre, :keywords, :format)
  end
end
