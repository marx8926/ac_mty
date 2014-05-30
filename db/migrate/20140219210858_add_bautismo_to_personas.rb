class AddBautismoToPersonas < ActiveRecord::Migration
  def change
  	add_column :personas, :dat_persona_bautismo, :date
  end
end