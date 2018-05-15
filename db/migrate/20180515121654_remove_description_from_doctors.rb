class RemoveDescriptionFromDoctors < ActiveRecord::Migration[5.0]
  def change
    remove_column :doctors, :description
  end
end
