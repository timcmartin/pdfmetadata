class BatchValidator < ActiveModel::Validator
  def validate(record)
    return record.errors[:path] << "cannot be empty." unless record.path.present?
    record.errors[:path] << 'does not exist.' unless File.exists?(record.batch_data)
  end
end
