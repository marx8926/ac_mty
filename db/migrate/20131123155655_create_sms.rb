class CreateSms < ActiveRecord::Migration
  def change
    create_table( :sms , :id=>false ) do |t|
      t.primary_key	:int_sms_id
      t.string :var_sms_mensaje, limit: 250
      t.datetime :dat_detallesms_fechahora
      t.timestamps
  	end
  end
end
