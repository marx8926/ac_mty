class CreateTurnos < ActiveRecord::Migration
  def change
    create_table( :turnos , :id=>false )do |t|
      t.primary_key :int_turno_id
      t.string :var_turno_horainicio, limit: 10
      t.string :var_turno_horafin, limit: 10
      t.integer :int_turno_dia
      t.references :servicio, index: true
      
      t.timestamps
    end
  end
end
