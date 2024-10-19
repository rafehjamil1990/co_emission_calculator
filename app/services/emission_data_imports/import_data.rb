module EmissionDataImports
  class ImportData
    include ExcelParser

    def initialize(import)
      @import = import
    end

    def execute
      return if @import.processed? || parsed_excel.blank?

      Import.begin_import(@import)
      @emission_data_imports = []

      parsed_excel.each do |row|
        emission_data_import = { source: row["Emission Source"], quantity: row["Quantity"], unit: row["Unit"], emission_factor: row["Emission Factor Name"], import_id: @import.id }
        @emission_data_imports << emission_data_import
      end
      EmissionDataImport.import @emission_data_imports
      Import.end_import(@import)
    end
  end
end
