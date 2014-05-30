class CreateIglesia < ActiveRecord::Migration
  def change
    create_table( :iglesia , :id=>false ) do |t|

      t.primary_key :int_iglesia_id
      t.datetime :dat_iglesia_fecregistro
      t.date :dat_iglesia_feccreacion
      t.string :var_iglesia_telefono, limit: 18
      t.string :var_iglesia_siglas, limit: 20
      t.string :var_iglesia_nombre, limit: 150
      t.string :var_iglesia_direccion, limit: 150
      t.string :var_iglesia_referencia, limit: 150
      t.float :dou_iglesia_longitud
      t.float :dou_iglesia_latitud
      t.references :ubigeo, index: true
      t.timestamps
    end
  end
end
