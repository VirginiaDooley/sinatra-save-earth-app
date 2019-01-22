class UpdateActionsWithUserId < ActiveRecord::Migration
  def change
    add_column :actions, :user_id, :string 
  end
end
