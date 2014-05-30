class CreateListaTemas < ActiveRecord::Migration
  def change
    create_table :lista_temas , { :id => false } do |t|
      t.primary_key :int_listatema_id
      t.references :herramienta_consolidacion , index: true

      t.timestamps
    end
  end
end
