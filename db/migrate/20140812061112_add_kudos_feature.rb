class AddKudosFeature < ActiveRecord::Migration
  def change
    add_column :posts, :kudos_count, :integer, :default => 0 
    add_column :comments, :kudos, :boolean, :default => false
  end
end
