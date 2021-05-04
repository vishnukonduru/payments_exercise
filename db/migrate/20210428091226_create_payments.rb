class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.belongs_to :loan
      t.timestamps
    end
  end
end
