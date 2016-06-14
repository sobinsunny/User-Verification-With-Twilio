class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.string :name, null: false
      t.string :email
      t.string :dob
      t.string :location
      t.string :phone_number
      t.string :email_token
      t.string :phone_token
      t.boolean :is_email_verified,  default: false
      t.boolean :is_phone_verified,  default: false
      t.timestamps null: false
    end
  end
end
