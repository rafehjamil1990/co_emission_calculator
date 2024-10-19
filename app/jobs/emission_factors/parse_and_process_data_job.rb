module EmissionFactors
  class ParseAndProcessDataJob
    include Sidekiq::Job
    queue_as :default

    def perform(import_id)
      import = Import.find_by(id: import_id)
      EmissionFactors::ImportData.new(import).execute
    end
  end
end
