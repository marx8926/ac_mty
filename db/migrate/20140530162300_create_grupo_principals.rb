class CreateGrupoPrincipals < ActiveRecord::Migration
  def change
    create_table :grupo_principals , { :id=>false} do |t|
      t.primary_key :int_grupoprincipal_id
      t.string :var_grupoprincipal_codigo , limit: 5
      t.integer :int_grupoprincipal_tipo
      t.integer :int_grupoprincipal_responsable
      t.date :dat_grupoprincipal_fechaCreacion
      t.integer :int_grupoprincipal_nromiembros
      t.timestamps
    end
  end
end
