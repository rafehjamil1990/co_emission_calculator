class ImportsController < ApplicationController
  def create
    import = Import.new(import_params.merge(status: "unprocessed"))

    if import.save
      import.process_file
      head :created
    else
      head :unprocessable_entity
    end
  end

  private

  def import_params
    params.require(:import).permit(:import_class, :excel)
  end
end
