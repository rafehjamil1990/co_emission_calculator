class CreateImports < ActiveRecord::Migration[7.2]
  def change
    create_table :imports do |t|
      t.string :status, limit: 30, index: true
      t.datetime :started_at
      t.datetime :ended_at
      t.jsonb :import_errors, default: {}
      t.string :import_class

      t.timestamps
    end
  end
end
