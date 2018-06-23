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
    score_path = File.join(ENV["INPUT"], directory_params["path"])
    score_values = YAML.load_file(File.join(score_path, "scores.yml"))
    scores = score_values[:score]
    scores.each do |score|
      score[:path] = File.join(directory_params["path"], score[:filename])
      chart = Chart.new(score)
      chart.process_pdf if chart.valid?
      if chart.valid? && chart.process_pdf
        flash[:notice] = "#{chart.title} has been updated."
      else
        flash.now[:alert] = "#{chart.errors.full_messages}"
      end
    end
    render action: 'batch'
  end

  private

  def chart_params
    params.require(:chart).permit(:title, :path, :composer, :genre, :keywords, :format, :filename)
  end

  def directory_params
    params.require(:chart).permit(:path)
  end
end
