# chart.rb
class Chart
  require 'active_support/inflector'
  include Filemover

  attr_accessor(:title, :path, :composer, :genre, :keywords, :format)

  def initialize(attributes = {})
    @title = attributes[:title]
    @path = attributes[:path]
    @composer = attributes[:composer]
    @genre = attributes[:genre]
    @keywords = attributes[:keywords]
    @format = attributes[:format]
    raise ArgumentError, "Must provide a valid path." if @path.nil?
  end

  def pdf_hash
    { Title: @title, Author: @composer, Keywords: @keywords, Subject: @genre, Creator: @format }
  end

  def backup_file
    File.join(Rails.public_path, ENV["BACKUP"], @path)
  end

  def processed_file
    File.join(Rails.public_path, ENV["OUTPUT"], @path)
  end

  def raw_file
    File.join(ENV["INPUT"], @path)
  end

  def process_pdf
    raise ArgumentError, "File does not exist" unless File.exist?(raw_file)
    backup_and_move(raw_file, backup_file, processed_file)
    pdf = Prawn::Document.new(template: processed_file, info: pdf_hash)
    pdf.render_file processed_file
    move_with_path(processed_file, raw_file)
  end
end
