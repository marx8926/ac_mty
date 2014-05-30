class Iglesia < ActiveRecord::Base
	belongs_to :ubigeo
	has_many :personas
end
