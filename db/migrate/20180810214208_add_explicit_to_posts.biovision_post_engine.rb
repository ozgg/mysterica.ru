# This migration comes from biovision_post_engine (originally 20180810111111)
class AddExplicitToPosts < ActiveRecord::Migration[5.2]
  def up
    unless column_exists?(:posts, :explicit)
      add_column :posts, :explicit, :boolean, default: false, null: false
    end
  end

  def down
    # No rollback needed
  end
end
