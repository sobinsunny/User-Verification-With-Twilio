class ChangeDobFAtaTypeToDate < ActiveRecord::Migration
  def up
    change_column :employers, :dob, :datetime
  end

  def down
       change_column :employers, :dob, :string
  end
end
