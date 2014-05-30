module ConfiguracionHelper
	def servicios_select
		select("", "servicio", Servicio.all.collect {|p| [ p.var_servicio_nombre, p.int_servicio_id ] },{ include_blank: false }, { class: "form-control validate[required]"})
	end

	def servicios_select_sin
		select("", "servicio", Servicio.all.collect {|p| [ p.var_servicio_nombre, p.int_servicio_id ] },{include_blank: "Todos" }, { class: "form-control"})
	end
end
