class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :serial_no
			t.string :region
			t.string :state
			t.string :district
			t.string :center
			t.string :bank_group
			t.string :bank
			t.string :branch
			t.string :part1_code
			t.string :part2_code
			t.string :population_group
			t.string :date_of_open
			t.string :ad_category
			t.string :licence_no
			t.string :licence_date
			t.text :address
			t.string :branch_office
      t.timestamps
    end
  end
end
