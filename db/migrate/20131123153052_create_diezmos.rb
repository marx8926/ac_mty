class CreateDiezmos < ActiveRecord::Migration
  def change
    create_table( :diezmos, :id=>false ) do |t|
      t.primary_key :int_diezmo_id
      t.decimal :dec_diezmo_monto, precision: 18, scale: 2
      t.datetime :dat_diezmo_fecharegistro
      t.string :var_diezmo_peticion, limit: 200

      t.references :persona, index: true
      
      t.timestamps
    end
  end
end
