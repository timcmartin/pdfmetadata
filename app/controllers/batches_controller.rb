class BatchesController < ApplicationController
  def create
    @batch = Batch.new(batch_params)
    unless @batch.valid?
      flash.now[:alert] = "#{@batch.errors.full_messages.to_sentence}"
      render :action => 'create'
    end
  end

  def batch_file
  end

  def generate
    @batch_file = BatchFile.new(batch_params)
    unless @batch_file.valid?
      flash.now[:alert] = "#{@batch_file.errors.full_messages.to_sentence}"
      render :action => 'generate'
    end
  end

  private

    def batch_params
      params.require(:batch).permit(:path)
    end
end
