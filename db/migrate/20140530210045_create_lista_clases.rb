class CreateListaClases < ActiveRecord::Migration
  def change
    create_table :lista_clases , { :id=>false } do |t|
      t.primary_key :int_listaclase_id
      t.string :var_listaclase_nombre, limit: 150
      t.string :var_listaclase_estado, limit: 1
      t.references :curso, index: true
      t.timestamps
    end
  end
end
