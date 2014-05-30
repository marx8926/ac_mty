class CreateHerramConsoConsolidadors < ActiveRecord::Migration
  def change
    create_table :herram_conso_consolidadors , { :id => false } do |t|
      t.primary_key :int_herramconsoConsolidador_id
      t.string :var_herramconsoConsolidador_estado
      t.date :dat_herramconsoConsolidador_fechaRealizado
      t.references :consolidador , index: true
      t.references :miembro , index: true
      t.references :herramienta_consolidacion 

      t.timestamps
    end
  end
end
