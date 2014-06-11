module InformacionHelper
	def grupos_principales_select
		select("", "grupo_principal", GrupoPrincipal.all.collect {|p| [ p.var_grupoprincipal_codigo, p.int_grupoprincipal_id ] }, {}, { class: "form-control"})
	end
end
