class CreateInscripcionAlumnos < ActiveRecord::Migration
  def change
    create_table :inscripcion_alumnos , { :id=>false }do |t|
      t.primary_key :int_inscripcionAlumno_id
      t.references :programar_curso, index: true
      t.string :var_inscripcionAlumno_estado, limit: 1
      t.references :persona, index: true
      t.timestamps
    end
  end
end
