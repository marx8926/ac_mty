class Servicio < ActiveRecord::Base
	has_many :turnos
	has_many :asistencias
end
