class CreateDireccions < ActiveRecord::Migration
  def change
    create_table( :direccions , :id=>false ) do |t|

      t.primary_key :int_direccion_id
      t.string :var_direccion_descripcion, limit: 100
      t.string :var_direccion_referencia, limit: 100
      t.float :dou_direccion_longitud
      t.float :dou_direccion_latitud
      t.string :var_direccion_estado, limit: 1

      t.references :ubigeo, index: true
      t.references :persona, index: true
      t.timestamps
    end
  end
end
