require 'roo'

task :populate_bank_branches => :environment do 
	branches = Roo::Excelx.new('/home/kushal/Downloads/icici-pune.xlsx')

	branches.each_with_index do |b, i|
		unless i == 0
			Bank.create!(
										:serial_no => b[0], 
										:region => b[1], 
										:state => b[2], 
										:district => b[3], 
										:center => b[4], 
										:bank_group => b[5], 
										:bank => b[6], 
										:branch => b[7], 
										:part1_code => b[8], 
										:part2_code => b[9], 
										:population_group => b[10], 
										:date_of_open => b[11], 
										:ad_category => b[12], 
										:licence_no => b[13], 
										:licence_date => b[14], 
										:address => b[15], 
										:branch_office => b[16]
									)
		end
	end
end