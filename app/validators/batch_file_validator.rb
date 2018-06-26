class BatchFileValidator < ActiveModel::Validator
  def validate(record)
    return record.errors[:path] << "cannot be empty." unless record.path.present?
    record.errors[:path] << 'does not contain PDFs.' if record.source_files.empty?
  end
end
