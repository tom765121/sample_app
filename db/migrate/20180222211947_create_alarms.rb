class CreateAlarms < ActiveRecord::Migration[5.1]
  def change
    create_table :alarms do |t|
      t.string :message
      t.string :user_id
      t.timestamps
    end
  end
end
