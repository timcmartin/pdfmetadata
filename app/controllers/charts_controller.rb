class ChartsController < ApplicationController
  def batch
  end

  def create
    @chart = Chart.new(chart_params)
    if @chart.valid? && @chart.process_pdf
      flash[:notice] = "#{@chart.title} has been updated."
      redirect_to '/'
    else
      flash.now[:alert] = "#{@chart.errors.full_messages}"
      render :action => 'index'
    end
  end

  def directory
    @batch = Batch.new(directory_params)
    unless @batch.valid?
      flash.now[:alert] = "#{@batch.errors.full_messages}"
      render :action => 'batch'
    end
  end

  private

  def chart_params
    params.require(:chart).permit(:title, :path, :composer, :genre, :keywords, :format, :filename)
  end

  def directory_params
    params.require(:chart).permit(:path)
  end
end
