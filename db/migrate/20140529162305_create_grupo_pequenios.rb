class CreateGrupoPequenios < ActiveRecord::Migration
  def change
    create_table :grupo_pequenios , { id: false , primary_key: 'var_grupopequenio_id'} do |t|
      t.string :var_grupopequenio_id, limit: 5, primary: true
      t.string :var_grupopequenio_nombre, limit: 150
      t.integer :int_grupopequenio_tipo
      t.references :lugar, index: true
      t.date :dat_grupopequenio_fechaInicio
      t.integer :int_grupopequenio_diaReunion
      t.string :var_grupopequenio_hora, limit: 10
      t.string :var_grupopequenio_direccion, limit: 200
      t.integer :int_grupopequenio_frecuenciareunion
      t.integer :int_grupopequenio_responsable
      t.timestamps
    end

    execute %Q{ ALTER TABLE "grupo_pequenios" ADD PRIMARY KEY ("var_grupopequenio_id"); }
  end
end
