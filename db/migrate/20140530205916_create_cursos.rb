class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos , { :id => false } do |t|
  	  t.primary_key :int_curso_id
  	  t.string :var_curso_nombre
  	  t.integer :int_curso_tipo
  	  t.integer :int_curso_nroclases
  	  t.string :var_curso_estado, limit: 1
  	  t.integer :int_curso_dependiente
      t.timestamps
    end
  end
end
