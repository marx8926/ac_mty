class InscripcionAlumno < ActiveRecord::Base
	belongs_to :persona
	belongs_to :programar_curso
	has_many :control_asistencias
	has_many :lista_notas
end
