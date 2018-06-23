class BatchesController < ApplicationController
  def create
    @batch = Batch.new(batch_params)
    unless @batch.valid?
      flash.now[:alert] = "#{@batch.errors.full_messages}"
      render :action => 'batch'
    end
  end

  private

    def batch_params
      params.require(:batch).permit(:path)
    end
end
