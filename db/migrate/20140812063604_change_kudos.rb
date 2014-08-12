class ChangeKudos < ActiveRecord::Migration
  def change
    remove_column :comments, :kudos
    add_column :comments, :kudos, :boolean
  end
end
