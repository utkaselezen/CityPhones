class CreatePhones < ActiveRecord::Migration[5.2]
  def change
    create_table :phones do |t|
      t.integer :phone
      t.boolean :is_custom
      t.timestamps
    end
  end
end
