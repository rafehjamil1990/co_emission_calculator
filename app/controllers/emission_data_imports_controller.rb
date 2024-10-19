class EmissionDataImportsController < ApplicationController
  def index
    @emission_data_imports = EmissionDataImport.all
  end
end
