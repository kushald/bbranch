class CreateNeftBanks < ActiveRecord::Migration
  def change
    create_table :neft_banks do |t|
      t.string :name
      t.string :display_name

      t.timestamps
    end
  end
end
