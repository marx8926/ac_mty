class CreateConsolidadors < ActiveRecord::Migration
  def change
    create_table :consolidadors , { :id => false }do |t|
      t.primary_key :int_consolidador_id
      t.references :persona, index: true
      t.date :dat_consolidador_fechaAsignacion
      t.string :var_consolidador_estado , limit: 1
      t.references :grupo_principal, index: true
      t.timestamps
    end
  end
end
