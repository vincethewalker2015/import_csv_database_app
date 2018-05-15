class CreateDoctors < ActiveRecord::Migration[5.0]
  def change
    create_table :doctors do |t|
      t.string :ccg
      t.string :description
      t.string :postcode
      t.string :practice_name
      t.string :address
      t.string :list_size
      t.string :brick
      t.string :telephone
    end
  end
end
