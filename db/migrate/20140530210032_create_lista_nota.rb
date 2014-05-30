class CreateListaNota < ActiveRecord::Migration
  def change
    create_table :lista_nota , { :id=>false } do |t|
      t.primary_key :int_listanota_id
      t.references :inscripcion_alumno, index: true
      t.float :dec_listanota_nota
      t.date :dat_listanota_fechaRegistro
      t.timestamps
    end
  end
end
