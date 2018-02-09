class CreateShippingInformations < ActiveRecord::Migration[5.1]
  def change
    create_table :shipping_informations, id: :uuid do |table|
      table.text :name, null: false
      table.text :address, null: false
      table.string :postal, null: false
      table.string :city, null: false
      table.string :state, null: false
      table.uuid :account_id, null: false
      table.timestamps null: false

      table.foreign_key :accounts, column: :account_id
    end
  end
end
