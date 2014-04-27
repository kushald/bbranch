require 'roo'
require 'rubygems'
require 'mechanize'
require 'open-uri'
require 'pry'
require 'csv'

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

task :populate_rbi_neft_list => :environment do

	
	agent = Mechanize.new

	agent.get("http://www.rbi.org.in/Scripts/bs_viewcontent.aspx?Id=2009")

	links = agent.page.links_with(:href => %r{.xls})
	result ={}
	links.each do |link|
		result[link.text] = link.href
	end

	result.keys.each do |bank|
		NeftBank.create!(:name => bank)
	end

	# agent2 = Mechanize.new
	# agent2.pluggable_parser.default = Mechanize::Download

	# result.each do |name,link|
	# 	agent2.get(link).save(name+".xls")
	# end
end

task :populate_ifsc_code => :environment do 

	neft = NeftBank.all

	binding.pry
	neft.each do |bank|
		next if bank.id == 1
		branches = Roo::Excelx.new("/home/kushal/workspace/ruby/rbi/#{bank.name}.xlsx", :zip, :warning)
		p bank.name
		branches.each_with_index do |b,i|
			unless i == 0
				Ifsc.create!(
											:name => b[0],
								      :ifsc => b[1],
								      :micr => b[2],
								      :branch => b[3],
								      :address => b[4],
								      :contact => b[5],
								      :city => b[6],
								      :district => b[7],
								      :state => b[8],
								      :neft_bank_id => bank.id
										)
			end
		end		
	end
end




desc "Read data from CSV into Ifsc table"
task :load_ifsc_code => :environment do
	#neft = NeftBank.all.limit 10
	begin
   # neft.each do |bank|
   # 	p bank.name
   # 	file = CSV.read("/home/kushal/workspace/ruby/rbi/csv/#{bank.name}.csv")
   # 	p file.size
   # 	file[1..-1].each do |row|
   # 		Ifsc.create!(
			# 								:name => row[0],
			# 					      :ifsc => row[1],
			# 					      :micr => row[2],
			# 					      :branch => row[3],
			# 					      :address => row[4],
			# 					      :contact => row[5],
			# 					      :city => row[6],
			# 					      :district => row[7],
			# 					      :state => row[8],
			# 					      :neft_bank_id => bank.id
			# 							)
   # 	#libreoffice --headless --convert-to csv --outdir ~/workspace/ruby/rbi/ *.xls
   # 	end

  	file = CSV.read("/home/kushal/Documents/KUSHAL/IFCB2009_04.csv")
  	binding.pry
  	file[1..-1].each do |row|
	  	# Ifsc.create!(
				# 								:name => row[0],
				# 					      :ifsc => row[1],
				# 					      :micr => row[2],
				# 					      :branch => row[3],
				# 					      :address => row[4],
				# 					      :contact => row[5],
				# 					      :city => row[6],
				# 					      :district => row[7],
				# 					      :state => row[8],
				# 					      :neft_bank_id => 5
				# 							)
   end
	end
end

desc "load ifsc via xlxs"
task :load_ifsc_xlxs => :environment do
	branches = Roo::Excelx.new("/home/kushal/workspace/ruby/rbi/#{ENV['name']}.xlsx")
	
		branches.each_with_index do |b,i|
			unless i == 0
				Ifsc.create!(
											:name => b[0],
								      :ifsc => b[1],
								      :micr => b[2],
								      :branch => b[3],
								      :address => b[4],
								      :contact => b[5],
								      :city => b[6],
								      :district => b[7],
								      :state => b[8],
								      :neft_bank_id => ENV['bid']
										)
				p "=======================#{i}=============================================="
			end
		end		
end