# batch.rb
class Batch
  include ActiveModel::Model

  validates_with BatchValidator

  attr_accessor :path, :scores, :valid_charts, :invalid_charts

  def initialize(attributes = {})
    super
    @valid_charts = []
    @invalid_charts = []
    process_files
  end

  def batch_data
    File.join(ENV["INPUT"], path, "scores.yml")
  end

  def scores
    return [] unless self.valid?
    YAML.load_file(batch_data)
  end

  def process_files
    return if scores.empty?
    scores.each do |score|
      score[:path] = File.join(path, score[:filename])
      chart = Chart.new(score)
      if chart.valid? && chart.process_pdf
        @valid_charts << chart
      else
        @invalid_charts << chart
      end
    end
  end
end
