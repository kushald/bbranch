class AddIndexUniqueIfscCode < ActiveRecord::Migration
  def change
  	# add_index :ifscs, :ifsc, unique: true
  	# add_index :ifscs, :micr, unique: true
  end
end
