class CreateIfscs < ActiveRecord::Migration
  def change
    create_table :ifscs do |t|
      t.string :name
      t.string :ifsc
      t.string :micr
      t.string :branch
      t.text :address
      t.string :contact
      t.string :city
      t.string :district
      t.string :state
      t.integer :neft_bank_id

      t.timestamps
    end
  end
end
