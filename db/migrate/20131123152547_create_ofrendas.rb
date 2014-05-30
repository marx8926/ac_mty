class CreateOfrendas < ActiveRecord::Migration
  def change
    create_table( :ofrendas , :id=>false) do |t|

      t.primary_key :int_ofrenda_id
      t.decimal :dec_ofrenda_monto, precision: 18, scale: 2
      t.datetime :dec_ofrenda_fecharegistro

      t.references :turno, index: true
      
      t.timestamps
    end
  end
end
