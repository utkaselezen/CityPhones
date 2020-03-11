class AddPhoneToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :phone, foreign_key: true
  end
end
