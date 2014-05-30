class CreateProgramarCursos < ActiveRecord::Migration
  def change
    create_table :programar_cursos , { :id=> false } do |t|
      t.primary_key :int_programarcurso_id
      t.references :curso, index: true
      t.references :maestro, index: true
      t.date :dat_programarcurso_fechaRegistro
      t.date :dat_programarcurso_fechaApertura
      t.date :dat_programarcurso_fechaInicio
      t.date :dat_programarcurso_fechaFin
      t.integer :int_programarcurso_turno
      t.string :var_programarcurso_horaInicio, limit: 10
      t.string :var_programarcurso_horaFin, limit: 10
      t.integer :int_programarcurso_suplente
      t.integer :int_programarcurso_frecuencia
      t.string :var_programarcurso_estado, limit: 1
      t.references :ambiente 
      t.timestamps
    end
  end
end
