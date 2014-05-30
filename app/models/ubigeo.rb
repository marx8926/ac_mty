class Ubigeo < ActiveRecord::Base
	has_many :iglesias
	has_many :direccions

	def json_tabla
		@all = Ubigeo.all

	end
end
