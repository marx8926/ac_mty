class CreatePersonaConsolidadors < ActiveRecord::Migration
  def change
    create_table :persona_consolidadors , { :id => false } do |t|
      t.primary_key :int_personaconsolidador_id
      t.references :consolidador , index: true
      t.references :miembro , index: true
      t.date :dat_perconsolidador_fechaAsignacion
      t.string :var_perconsolidador_estado , limit: 1

      t.timestamps
    end
  end
end
