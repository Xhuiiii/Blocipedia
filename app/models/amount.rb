class Amount < ActiveRecord::Base
	def self.default
		return 15_00
	end

	def self.sum
		return 15.00
	end
end
