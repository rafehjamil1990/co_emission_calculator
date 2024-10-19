module EmissionDataImports
  class ParseAndProcessDataJob
    include Sidekiq::Job
    queue_as :default

    def perform(import_id)
      import = Import.find_by(id: import_id)
      EmissionDataImports::ImportData.new(import).execute
      EmissionDataImports::ProcessData.new(import).execute
    end
  end
end
