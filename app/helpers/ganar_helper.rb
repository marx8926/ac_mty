module GanarHelper
	def lugar_select
		select("", "lugar", Lugar.all.collect {|p| [ p.var_lugar_descripcion, p.int_lugar_id ] }, {}, { class: "form-control"})
	end
end