class CreateControlAsistencia < ActiveRecord::Migration
  def change
    create_table :control_asistencia , { :id=> false} do |t|
      t.primary_key :int_controlasistencia_id
      t.references :inscripcion_alumno
      t.date :dat_controlasistencia_fecha
      t.string :var_controlasistencia_estado , limit: 1
      t.timestamps
    end
  end
end
