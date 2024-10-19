class CreateEmissionDataImports < ActiveRecord::Migration[7.2]
  def change
    create_table :emission_data_imports do |t|
      t.string :source
      t.string :quantity
      t.string :unit
      t.string :emission_factor
      t.string :result
      t.references :import

      t.timestamps
    end
  end
end
