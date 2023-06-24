class AddOccupationToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :occupation, :text
  end
end
