class CreateConstantes < ActiveRecord::Migration
  def change
    create_table( :constantes , :id=>false) do |t|
      t.primary_key :int_constante_id
      t.string :var_constante_descripcion, limit: 50
      t.integer :int_constante_valor
      t.integer :int_constante_clase
      t.timestamps
    end
  end
end
