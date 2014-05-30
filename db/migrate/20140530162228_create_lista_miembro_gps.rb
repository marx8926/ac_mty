class CreateListaMiembroGps < ActiveRecord::Migration
  def change
    create_table( :lista_miembro_gps , :id=>false) do |t|
	    t.primary_key :int_listamiembrogp_id
      t.string :grupo_pequenio_id, limit: 5, index: true
      t.references :persona, index: true
      t.date :dat_listamimebrogp_fechaRegistro
      t.string :var_listamiembrogp_estado, limit: 1
      t.timestamps
    end

    execute %Q{ ALTER TABLE "lista_miembro_gps"
  ADD CONSTRAINT "foreign_grupo_pequenio" FOREIGN KEY ("grupo_pequenio_id") REFERENCES
   "grupo_pequenios" ("var_grupopequenio_id")
   ON UPDATE NO ACTION ON DELETE NO ACTION;
CREATE INDEX fki_foreign_grupo_pequenio
  ON "lista_miembro_gps"("grupo_pequenio_id"); }

  end
end
