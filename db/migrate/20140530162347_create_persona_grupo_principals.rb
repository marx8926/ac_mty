class CreatePersonaGrupoPrincipals < ActiveRecord::Migration
  def change
    create_table :persona_grupo_principals , { :id=>false } do |t|
      t.primary_key :int_pergrupoprincipal_id
      t.references :grupo_principal, index: true
      t.string :var_pergrupoprincipal_estado , limit: 1
      t.date :dat_pergrupoprincipal_fechaAsignacion
      t.references :miembro, index: true
      t.timestamps
    end
  end
end
