class EmissionDataImport < ApplicationRecord
  belongs_to :import

  validates_presence_of :source, :quantity, :unit, :emission_factor
end
