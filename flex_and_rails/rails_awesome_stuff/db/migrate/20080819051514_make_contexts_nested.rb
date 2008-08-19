class MakeContextsNested < ActiveRecord::Migration
  def self.up
    add_column :contexts, :lft, :integer
    add_column :contexts, :rgt, :integer
    add_column :contexts, :parent_id, :integer
  end

  def self.down
    remove_column :contexts, :lft
    remove_column :contexts, :rgt
    remove_column :contexts, :parent_id
  end
end
