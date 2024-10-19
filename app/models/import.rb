class Import < ApplicationRecord
  IMPORT_STATUSES = {
    unprocessed: "unprocessed",
    pending: "pending",
    processed: "processed",
    completed: "completed",
    errors: "errors",
    empty: "empty"
  }

  has_one_attached :csv
  has_one_attached :excel
  has_many :emission_data_imports
  belongs_to :importable, polymorphic: true, optional: true

  def processed?
    status == "processed"
  end

  def completed?
    status == "completed"
  end

  def unprocessed?
    status == "unprocessed"
  end

  def process_file
    "#{import_class}::ParseAndProcessDataJob".constantize.perform_async(self.id)
  end

  def self.begin_import(import)
    import.started_at = DateTime.now
    import.status = "pending"
    import.save
  end

  def self.end_import(import)
    import.ended_at = DateTime.now
    import.status = "processed"
    import.save
  end
end
