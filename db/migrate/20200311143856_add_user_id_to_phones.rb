class AddUserIdToPhones < ActiveRecord::Migration[5.2]
  def change
    add_column :phones, :user_id, :integer
  end
end
