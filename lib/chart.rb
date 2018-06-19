# chart.rb
class Chart
  require 'active_support/inflector'
  require 'fileutils'
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

  def backup_file
    File.join(Rails.public_path, ENV["BACKUP"], @path)
  end

  def pdf_hash
    { Title: @title, Author: @composer, Keywords: @keywords, Subject: @genre, Creator: @format }
  end

  def processed_file
    File.join(Rails.public_path, ENV["OUTPUT"], @path)
  end

  def raw_file
    File.join(ENV["INPUT"], @path)
  end

  def process_pdf
    raise ArgumentError, "File does not exist" unless File.exist?(raw_file)
    move_with_path(raw_file, backup_file)
    copy_with_path(backup_file, processed_file)
    pdf = Prawn::Document.new(template: processed_file, info: pdf_hash)
    pdf.render_file processed_file
    move_with_path(processed_file, raw_file)
  end

  private

    def copy_with_path(src, dst)
      FileUtils.mkdir_p(File.dirname(dst))
      FileUtils.cp(src, dst)
    end

    def move_with_path(src, dst)
      FileUtils.mkdir_p(File.dirname(dst))
      FileUtils.mv(src, dst)
    end
end
