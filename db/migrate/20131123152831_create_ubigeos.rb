class CreateUbigeos < ActiveRecord::Migration
  def change
    create_table( :ubigeos , :id=>false)do |t|
      t.primary_key :int_ubigeo_id
      t.string :string_ubigeo_descripcion, limit: 50
      t.integer :int_ubigeo_departamento
      t.integer :int_ubigeo_provincia
      t.integer :int_ubigeo_distrito
      t.integer :int_ubigeo_dependencia
      t.float :float_ubigeo_latitud
      t.float :float_ubigeo_longitud

      t.timestamps
    end
  end
end
