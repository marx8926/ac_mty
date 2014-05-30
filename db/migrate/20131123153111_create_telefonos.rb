class CreateTelefonos < ActiveRecord::Migration
  def change
    create_table( :telefonos , :id=>false) do |t|
      t.primary_key :int_telefono_id
      t.integer :int_telefono_tipo
      t.string :var_telefono_codigo, limit: 5
      t.string :var_telefono_numero, limit: 18

      t.references :persona, index: true
      t.timestamps
    end
  end
end
