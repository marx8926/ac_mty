class Turno < ActiveRecord::Base
	belongs_to :servicio
	has_many :ofrendas
end
