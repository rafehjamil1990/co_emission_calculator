module EmissionDataImports
  class ProcessData
    def initialize(import)
      @import = import
    end

    def execute
      return if @import.completed? || @import.unprocessed?

      emissions_array = []
      emission_data.each do |emission|
        emission.result = calculate_result(emission)
        emissions_array << emission
      end
      EmissionDataImport.import(emissions_array, on_duplicate_key_update: { conflict_target: %i[id], columns: %i[result] })
      @import.update(status: "completed")
    end

    private

    def emission_factors
      @emission_factors ||= EmissionFactor.all.index_by(&:name)
    end

    def emission_data
      @emission_data = @import.emission_data_imports
    end

    def calculate_result(emission)
      emission_factor = emission_factors[emission.emission_factor]
      return "N/A" if emission_factor.blank?

      convert_to_grams(emission.quantity.to_d * emission_factor.quantity.to_d, emission_factor.unit)
    end

    def convert_to_grams(quantity, unit)
      if unit.include?("kg")
        (quantity * 1000).to_d
      elsif unit.include?("mg") & quantity.positive?
        (quantity / 1000).to_d
      elsif unit.include?("ppm")
        (quantity / 1001.142303).to_d
      else
        quantity
      end
    end
  end
end
