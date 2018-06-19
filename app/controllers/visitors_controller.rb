class VisitorsController < ApplicationController
  def chart
    @chart = Chart.new(params["chart"])
    if @chart.process_pdf
      render json: @chart
    else
      render json: { errors: @chart.errors.full_messages }, status: 422
    end
  end
end
