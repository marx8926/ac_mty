class Consolidador < ActiveRecord::Base
	belongs_to :personas
	belongs_to :grupo_principals
	has_many :persona_Consolidadors
end
