class DashboardController < ApplicationController
  def index
    @import = Import.new
    @emission_factors = EmissionFactor.all
  end
end
