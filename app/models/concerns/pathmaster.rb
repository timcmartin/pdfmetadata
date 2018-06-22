require 'active_support/concern'
# Pathmaster
# Used to move files
module Pathmaster
  require 'fileutils'
  extend ActiveSupport::Concern

  def backup_and_move(src, dst, copy)
    move_with_path(src, dst)
    copy_with_path(dst, copy)
  end

  def copy_with_path(src, dst)
    FileUtils.mkdir_p(File.dirname(dst))
    FileUtils.cp(src, dst)
  end

  def move_with_path(src, dst)
    FileUtils.mkdir_p(File.dirname(dst))
    FileUtils.mv(src, dst)
  end
end
