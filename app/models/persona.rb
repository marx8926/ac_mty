class Persona < ActiveRecord::Base
	belongs_to :iglesia
	has_many :telefonos
	belongs_to :lugar
	belongs_to :consolidador
	has_many :nivel_crecimientos
	has_many :diezmos
	has_many :direccions
	has_many :peticions
	has_many :lista_miembro_gp
	has_many :inscripcion_alumno
	has_many :consolidador
	has_one :miembro
end
