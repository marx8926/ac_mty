class ProgramarCurso < ActiveRecord::Base
	belongs_to :maestro
	belongs_to :ambiente
	belongs_to :curso
	has_many :inscripcion_alumnos
end
