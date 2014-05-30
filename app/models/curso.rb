class Curso < ActiveRecord::Base
	has_many :programar_cursos
	has_many :lista_clases

end
