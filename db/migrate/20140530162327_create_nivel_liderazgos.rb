class CreateNivelLiderazgos < ActiveRecord::Migration
  def change
    create_table :nivel_liderazgos, { :id=>false } do |t|

      t.primary_key :int_niveliderazgo_id
      t.integer :int_niveliderazgo_tiponivel
      t.integer :int_niveliderazgo_responsable
      t.references :miembro, index: true
      t.timestamps
    end
  end
end
