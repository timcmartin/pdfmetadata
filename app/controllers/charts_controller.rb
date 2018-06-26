class ChartsController < ApplicationController
  def create
    @chart = Chart.new(chart_params)
    if @chart.valid? && @chart.process_pdf
      flash[:notice] = "#{@chart.title} has been updated."
      redirect_to '/'
    else
      flash.now[:alert] = "#{@chart.errors.full_messages.to_sentence}"
      render :action => 'index'
    end
  end

  private

    def chart_params
      params.require(:chart).permit(:title, :path, :composer, :genre, :keywords, :format, :filename)
    end
end
