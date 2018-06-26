# batch_file.rb
class BatchFile
  include ActiveModel::Model

  validates_with BatchFileValidator

  attr_accessor :path, :scores

  def initialize(attributes = {})
    super
    process_files
  end

  def source_dir
    File.join(ENV["INPUT"], path)
  end

  def source_files
    Dir["#{source_dir}/*.pdf"]
  end

  def batch_data
    File.join(ENV["INPUT"], path, "scores.yml")
  end

  def scores
    return [] unless self.valid?
    scores = []
    source_files.each do |f|
      data = { filename: File.basename(f),
               title: File.basename(f, File.extname(f)).titleize,
               composer: '',
               keywords: '',
               genre: '',
               format: '' }
      scores << data
    end
    scores
  end

  def process_files
    return if scores.empty?
    File.open(batch_data, 'w') { |file| file.write scores.to_yaml }
  end
end
