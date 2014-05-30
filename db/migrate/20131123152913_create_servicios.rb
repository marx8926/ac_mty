class CreateServicios < ActiveRecord::Migration
  def change
    create_table( :servicios , :id=>false ) do |t|
      t.primary_key :int_servicio_id
      t.string :var_servicio_nombre, limit: 150
      t.integer :int_servicio_tipo
      t.timestamps
    end
  end
end
