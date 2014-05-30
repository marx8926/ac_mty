class CreateLugars < ActiveRecord::Migration
  def change
    create_table( :lugars , :id=>false )do |t|
      t.primary_key :int_lugar_id
      t.string        :var_lugar_descripcion, limit: 100
      t.string        :var_lugar_estado, limit: 1

      t.timestamps
    end
  end
end