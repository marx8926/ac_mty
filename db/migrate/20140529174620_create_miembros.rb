class CreateMiembros < ActiveRecord::Migration
  def change
    create_table :miembros , { :id=>false } do |t|

      t.primary_key :int_miembro_id
      t.references :persona , index: true
      t.date :dat_miembro_fechaAsignacion
      t.string :var_miembro_estado, limit: 1
      t.timestamps
    end
  end
end
