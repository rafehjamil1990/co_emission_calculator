# Include in any Excel parser classes, for data being imported into our system via Excel.
#
# Provides a `parsed_excel` method, which takes care of all the standard header/value cleaning we need to do,
# and takes care of byte order mark (BOM) issues, common with files exported on windows.
#
# Expects a @excel_file instance variable
#
module ExcelParser
  extend ActiveSupport::Concern

  included do
    def parsed_excel
      @parsed_excel ||= self.class.parse(excel_file)
    end

    def excel_file
      return @excel_file if @excel_file.present?

      @import.excel.open do |file|
        @excel_file = Roo::Spreadsheet.open(file)
      end
      @excel_file
    end
  end

  class_methods do
    def parse(excel_file)
      sheet = excel_file.sheet(0)
      sheet.parse(headers: true).drop(1)
    end
  end
end
