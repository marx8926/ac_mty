class CreateAmbientes < ActiveRecord::Migration
  def change
    create_table :ambientes , { :id => false} do |t|
      t.primary_key :int_ambiente_id
      t.string :var_ambiente_nombre, limit: 150
      t.integer :int_ambiente_tipo
      t.integer :int_ambiente_nromaxpersonas
      t.string :var_ambiente_estado, limit: 1
      t.timestamps
    end
  end
end
