class CreatePersonas < ActiveRecord::Migration
  def change
    create_table( :personas , :id=>false) do |t|

      t.primary_key :int_persona_id
      t.datetime :dat_persona_fecregistro
      t.string :var_persona_nombres, limit: 45
      t.string :var_persona_apellidos, limit: 45
      t.integer :int_persona_edad
      t.date :dat_persona_fecNacimiento
      t.string :var_persona_profesion, limit: 45
      t.string :var_persona_ocupacion, limit:45
      t.string :var_persona_sexo, limit: 1
      t.string :var_persona_dni, limit: 10
      t.string :var_persona_estado, limit:1
      t.string :var_persona_email
      t.string :var_persona_invitado, limit: 100

      t.references :iglesia, index: true
      t.references :lugar, index: true

      t.timestamps
    end

  end

end