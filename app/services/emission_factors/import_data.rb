module EmissionFactors
  class ImportData
    include ExcelParser

    def initialize(import)
      @import = import
    end

    def execute
      return if @import.processed? || parsed_excel.blank?

      Import.begin_import(@import)
      EmissionFactor.delete_all
      @emission_factors = []
      parsed_excel.each do |row|
        emission_factor = { name: row["Name"], quantity: row["Quantity"], unit: row["Unit"] }
        @emission_factors << emission_factor
      end
      EmissionFactor.import @emission_factors
      Import.end_import(@import)
    end
  end
end
