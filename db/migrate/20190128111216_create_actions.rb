class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :action_name
      t.string :status
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
