# chart.rb
class Chart
  include Filemover
  include ActiveModel::Model

  attr_accessor(:title, :path, :composer, :genre, :keywords, :format, :filename)

  validates_with ChartValidator

  def initialize(attributes = {})
    super
  end

  def pdf_hash
    { Title: title, Author: composer, Keywords: keywords, Subject: genre, Creator: format }
  end

  def backup_file
    File.join(Rails.public_path, ENV["BACKUP"], path)
  end

  def processed_file
    File.join(Rails.public_path, ENV["OUTPUT"], path)
  end

  def raw_file
    File.join(ENV["INPUT"], path)
  end

  def process_pdf
    return unless self.valid?
    backup_and_move(raw_file, backup_file, processed_file)
    pdf = Prawn::Document.new(template: processed_file, info: pdf_hash)
    pdf.render_file processed_file
    move_with_path(processed_file, raw_file)
  end
end
