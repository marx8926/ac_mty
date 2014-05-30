class CreateHerramientaConsolidacions < ActiveRecord::Migration
  def change
    create_table :herramienta_consolidacions , { :id => false } do |t|
 	  t.primary_key :int_herramconsolidacion_id
 	  t.string :var_herramconsolidacion_descripcion , limit: 200
 	  t.integer :int_herramconsolidacion_nrodias
 	  t.integer :int_herramconsolidacion_repeticion
 	  t.string :var_herramconsolidacion_estado , limit: 1
      t.timestamps
    end
  end
end
