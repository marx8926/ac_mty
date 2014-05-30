class CreateCharts < ActiveRecord::Migration
  def change
    create_table( :charts, :id=> false ) do |t|

      t.primary_key :int_chart_id
      t.integer :int_chart_anio, default: 0
      t.integer :int_chart_mes, default: 0
      t.integer :int_chart_miembro, default: 0
      t.integer :int_chart_visita, default: 0
      t.integer :int_chart_joven, default: 0
      t.integer :int_chart_adulto, default: 0
      t.integer :int_chart_adolescente, default: 0
      t.integer :int_chart_ninio, default: 0

      t.timestamps
    end
  end
end
