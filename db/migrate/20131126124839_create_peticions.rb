class CreatePeticions < ActiveRecord::Migration
  def change
    create_table( :peticions, :id => false) do |t|

      t.primary_key :int_peticion_id
      t.string :var_peticion_motivooracion , limit: 300
      t.references :persona, index: true
      t.date :dat_peticion_fecha
      
      t.timestamps
    end
  end
end
