class CreateEmissionFactors < ActiveRecord::Migration[7.2]
  def change
    create_table :emission_factors do |t|
      t.string :name
      t.string :quantity
      t.string :unit

      t.timestamps
    end
  end
end
