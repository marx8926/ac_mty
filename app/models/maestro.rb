class Maestro < ActiveRecord::Base
	belongs_to :miembro
	has_many :programar_cursos
end
