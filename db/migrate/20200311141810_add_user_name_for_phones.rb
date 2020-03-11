class AddUserNameForPhones < ActiveRecord::Migration[5.2]
  def change
    add_column :phones, :user_name, :string
  end
end
