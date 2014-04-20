class NeftBank < ActiveRecord::Base

	def self.all_banks(name)
		all.collect { |b| b.name.downcase}.include? name.gsub("_",' ').downcase
	end
end
