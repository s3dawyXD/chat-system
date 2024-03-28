class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications, id: false do |t|
      t.string :id, limit: 36, primary_key: true, null: false
      t.string :name

      t.timestamps
    end
  end
end
