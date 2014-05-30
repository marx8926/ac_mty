class Direccion < ActiveRecord::Base
	belongs_to :ubigeo
	belongs_to :persona
end
