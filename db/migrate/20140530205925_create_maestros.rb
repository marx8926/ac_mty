class CreateMaestros < ActiveRecord::Migration
  def change
    create_table :maestros , { :id => false } do |t|
      t.primary_key :int_maestro_id
      t.string :var_maestro_id, limit: 5
      t.references :miembro, index: true
      t.date :dat_maestro_fechaRegistro
      t.string :var_maestro_especialidad, limit: 100
      t.string :var_maestro_estado, limit: 1
      t.string :maestrocol, limit: 45
      t.timestamps
    end
  end
end
